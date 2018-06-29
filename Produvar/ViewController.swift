//
//  ViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 25.04.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer ()
     let session = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
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
                if object.type == AVMetadataObjectTypeQRCode && self.isBeingDismissed==false{
                    Parameters.objectValue = object.stringValue
                    session.stopRunning()
                process(url: "https://prodapp.000webhostapp.com/searchbyscan", code: Parameters.objectValue)
            return
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
            let httpStatus = response as? HTTPURLResponse
            // Print out response string
            responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            print("responseString = \(responseString)")
            if (httpStatus?.statusCode == 200){
                
                DispatchQueue.main.async {
                    do {
                        if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            //if(convertedJsonIntoDict["status"] as! String=="success") {
                            if(convertedJsonIntoDict["manufacturer"] != nil) {
                                let manJson = convertedJsonIntoDict["manufacturer"] as! NSDictionary
                                
                                Parameters.manufacturer = Manufacturer(website: manJson["website"] as! String, name: manJson["name"] as! String, phonenumber: manJson["phonenumber"] as! String, email: manJson["email"] as! String)
                                if convertedJsonIntoDict["ordercode"] != nil {
                                    Parameters.orderCode = convertedJsonIntoDict["ordercode"] as! String
                                   
                                }
                                print(Parameters.manufacturer.name + " fffdgdfg")
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "orderInfoSegue", sender: nil)}
                                   
                            }
                            else{
                                /*let alert = UIAlertController(title: "Wrong code!".localized(lang: Parameters.language), message:"Check your email and enter right number!".localized(lang: Parameters.language), preferredStyle: .alert)
                                 let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                 alert.addAction(defaultAction)
                                 
                                 self.present(alert, animated: true, completion: nil)*/
                                
                            }
                        }
                    }
                        
                    catch let error as NSError {
                        print(error.localizedDescription)
                        
                    }
                }
                
            }
            else {
                DispatchQueue.main.async {
                    self.session.startRunning()
                    let alert = UIAlertController(title: "Wrong format!", message:"Make sure you are scanning an appropriate autorization tag", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    
                    self.present(alert, animated: true, completion: nil)}
                }
                
            
        }
        task.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderInfoSegue"{
    
         }
        
    }
    }




