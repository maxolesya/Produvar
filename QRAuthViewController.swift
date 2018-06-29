//
//  QRAuthViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 14.06.2018.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class QRAuthViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer ()
    let session = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "icons8-qr-код-26.png")
        tabBarItem.image = image
        
        
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
        // Do any additional setup after loading the view.
    }
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObjectTypeQRCode {
                    session.stopRunning()
                    process(url: "https://prodapp.000webhostapp.com/authenticate", code: object.stringValue)
                    
                    return
                }
            }
        }
    }

    func process(url:String,code:String)  {
        let parameters = [
            "code" :code
           
        ]
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                //    multipartFormData.append(imageData, withName: "user", fileName: "user.jpg", mimeType: "image/jpeg")
                
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
        }, to: url) { (result) in
            
            switch result {
            case .success(let upload, _, _):
               
                upload.responseJSON { response in
                    let result = response.data
                    do{
                        if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: result!, options: []) as? NSDictionary{
                            var role:String
                            if convertedJsonIntoDict["role"] == nil {role=""}else{role=convertedJsonIntoDict["role"] as! String}
                            var username:String
                            if convertedJsonIntoDict["username"] == nil {username=""}else{username=convertedJsonIntoDict["username"] as! String}
                            var bearer:String
                            if convertedJsonIntoDict["bearer"] == nil {bearer=""}else{bearer=convertedJsonIntoDict["bearer"] as! String}
                            var name:String
                            if convertedJsonIntoDict["name"] == nil {name=""}else{name=convertedJsonIntoDict["name"] as! String}
                            Parameters.user = User(role: role, name: name, bearer: bearer
                                , username: username)
                            //self.performSegue(withIdentifier: "authQRSegue", sender: self)
                            self.performSegue(withIdentifier: "authQRSegue", sender: self)
                            let alert = UIAlertController(title: "Hello! You have authorized successfully!", message: "", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)}
                       
                        return
                       
                    }
                    catch{
                        let alert = UIAlertController(title: "Wrong format or code!", message:"Try again", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        
                        self.present(alert, animated: true, completion: nil)}
                    self.session.startRunning()
                    
                }
                
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
        
    
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
