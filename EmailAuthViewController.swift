//
//  EmailAuthViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 02.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class EmailAuthViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSForegroundColorAttributeName: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSForegroundColorAttributeName: UIColor.white])
        userNameTextField.spellCheckingType = .no
        passwordTextField.autocorrectionType = .no
        userNameTextField.autocorrectionType = .no
        passwordTextField.spellCheckingType = .no


        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClick(_ sender: Any) {
        auth1(url: "https://prodapp.000webhostapp.com/login")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }
    func auth(url:String)  {
        let password = passwordTextField.text! as String
        let username = userNameTextField.text! as String
        userNameTextField.spellCheckingType = .no
        passwordTextField.autocorrectionType = .no
        userNameTextField.autocorrectionType = .no
        passwordTextField.spellCheckingType = .no
       
        
        // create the request
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
       // request.setValue(base64LoginData, forHTTPHeaderField: "Authorization")
        request.setValue(username, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")
        print("ok")
        //making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // check status code returned by the http server
                print("status code = \(httpStatus.statusCode)")
                var responseString = ""

               responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
               print("responseString = \(responseString)")

                // process result
            }
        }
        task.resume()
    }
    func auth1(url:String)  {
        
    
        let password = passwordTextField.text! as String
        let username = userNameTextField.text! as String
        
                // create the request
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        // request.setValue(base64LoginData, forHTTPHeaderField: "Authorization")
        request.setValue(username, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")
        print("ok")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            var responseString = ""
            // Print out response string
            responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            print("responseString = \(responseString)")
            
            
            DispatchQueue.main.async {
                
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                        print("here")
                        // print(convertedJsonIntoDict["status"] as! String)
                        let httpStatus = response as? HTTPURLResponse
                        
                        if  httpStatus?.statusCode == 200 {
                            let u = User(role: convertedJsonIntoDict["role"] as! String, name: convertedJsonIntoDict["name"] as! String, bearer: convertedJsonIntoDict["bearer"] as! String, username: convertedJsonIntoDict["username"] as! String)
                           Parameters.user = u
                            self.performSegue(withIdentifier: "userSegue", sender: self)
                          
                            //Parameters.auth = true;
                      
                            let alert = UIAlertController(title: "Hello, "+u.name, message: "", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)
                            //self.performSegue(withIdentifier: "afterAuthSegue", sender: nil)
                            // self.performSegue(withIdentifier: "tableViewSegue", sender: self)
                            

                            
                        }
                        else{
                            let alert = UIAlertController(title: "Wrong code!", message:"Check your email and enter right number!", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)}
                        
                    }
                    
                    
                }
                    
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    
                }
                
                
                
            }
            
        }
        
        
        
            task.resume()//} catch{}
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
