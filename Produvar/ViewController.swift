//
//  ViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 25.04.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer ()

    override func viewDidLoad() {
        super.viewDidLoad()
        //create seccion
        let session = AVCaptureSession()
        
        //Define capture device
        let capturedevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        // Do any additional setup after loading the view, typically from a nib.
        
        do{
            let input = try AVCaptureDeviceInput(device: capturedevice)
            session.addInput(input)
        }
        catch{print("Error")}
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        video = AVCaptureVideoPreviewLayer(session: session )
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubview(toFront: square)
        session.startRunning()
        //
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObjectTypeQRCode {
                    process(url: "https://prodapp.000webhostapp.com/searchbyscan", code: object.stringValue)
                    /*let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: {(nil) in
                            UIPasteboard.general.string = object.stringValue
                        }))
                    present(alert,animated: true,completion: nil)*/
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func process(url:String,code:String)  {
        
        let getString = "?code="+code
        var request = URLRequest(url: NSURL(string: url+getString)! as URL)
        request.httpMethod = "GET"
        var responseString = ""
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            print("responseString = \(responseString)")
            /*DispatchQueue.main.async {
                
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict["status"] as! String)
                        if(convertedJsonIntoDict["status"] as! String=="success") {
                            self.performSegue(withIdentifier: "afterAuthSegue", sender: self)
                            
                            Parameters.token = convertedJsonIntoDict["token"] as! String
                            Parameters.auth = true;
                            let alert = UIAlertController(title: "Thank you!".localized(lang: Parameters.language), message: "Now you can vote and ask questions!".localized(lang: Parameters.language), preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)
                            //self.performSegue(withIdentifier: "afterAuthSegue", sender: nil)
                            // self.performSegue(withIdentifier: "tableViewSegue", sender: self)
                            
                        }
                        else{
                            let alert = UIAlertController(title: "Wrong code!".localized(lang: Parameters.language), message:"Check your email and enter right number!".localized(lang: Parameters.language), preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)}
                    }
                }
                    
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    
                }
            }*/
        }
        
        task.resume()
    }


}

