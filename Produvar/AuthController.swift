//
//  AuthController.swift
//  Produvar
//
//  Created by Олеся Максакова on 15.05.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class AuthController: UIViewController {

    @IBAction func buttonSignClick(_ sender: Any) {
        
       
        
    }
    
    @IBOutlet var welcomeLabel: UILabel!
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    /*func post_question(url: String, ticket: String)  {
        var request = URLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        var body: [String: AnyObject]
        //body = ["username": Parameters.ticketNumber as AnyObject, "password": getAnswersString() as AnyObject,"token":Parameters.token as AnyObject]
        body = ["username": userNameTextField.text as AnyObject, "password": passwordTextField.text as AnyObject]

        
        let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        
        request.httpBody = jsonBody
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil { // обработка ошибки при отправке
                return
                
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            if((responseString?.contains("error"))! || (responseString?.contains("unregistered"))!) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title:"Wrong code!", message:"Check your ticket number!", preferredStyle:.alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    return}
                
                
            }
                //.localized(lang: Parameters.language)
            else{
                DispatchQueue.main.async {
                    // let alert = UIAlertController(title:NSLocalizedString("Number is correct!", comment: "number is correct"), message: NSLocalizedString("Check your email!", comment: "checking email"), preferredStyle: .alert)
                    let alert = UIAlertController(title: "Number is correct!", message:
                        "Check your email!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    
                    self.present(alert, animated: true, completion: nil)}
               ;
                
            }
            
            print("responseString = \(responseString)")
            
            
        }
        
        task.resume()
        
      
        
    }*/

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Welcome ",Parameters.user.name)
        welcomeLabel.text = "Welcome, "+Parameters.user.name
        emailLabel.text = Parameters.user.username
        let now =  NSDate(timeIntervalSinceNow: 24 * 60*60)
        print(now)
        
        let dateFormatter = DateFormatter()
        
       
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    
       let nowstring = dateFormatter.string(from: now as Date)

        print(nowstring)
        infoLabel.text = "You were logged in for 24 hours (until "+nowstring+") with your personal account"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
