//
//  EmailAuthViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 02.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit
import Alamofire

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

        let image = UIImage(named: "icons8-эл.-адрес-30.png")
        tabBarItem.image = image

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClick(_ sender: Any) {
        auth1(url: "https://prodapp.000webhostapp.com/login")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }
   
    func auth1(url:String)  {
        
        let password = passwordTextField.text! as String
        let username = userNameTextField.text! as String
        if password.isEmpty || username.isEmpty {
            let alert = UIAlertController(title: "Please, enter your login and password!", message:"Check your username, password and try again!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let parameters = [
            "username" :username,
            "password":password
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
                    Parameters.user = try JSONDecoder().decode(User.self, from: result!)
                        print(Parameters.user.bearer + " " + Parameters.user.role + " " + Parameters.user.username)
                        self.performSegue(withIdentifier: "userSegue", sender: self)
                        let alert = UIAlertController(title: "Hello, " +  Parameters.user.name, message: "", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    catch{
                        let alert = UIAlertController(title: "Wrong data!", message:"Check your username, password and try again!", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)}
                        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
