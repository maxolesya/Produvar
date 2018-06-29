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
        logout(url:"https://prodapp.000webhostapp.com/logout")
         
    }
    func logout(url:String)  {
       
        var request = URLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        var responseString:String  = ""
        request.setValue("Bearer " + Parameters.user.bearer, forHTTPHeaderField: "Authorization")
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
                Parameters.user = User(role: "", name: "", bearer: "", username: "")
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: "You have logged out successfully!", message:"", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: self.someHandler)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
               }
                
               
               }
                
            else {
                let alert = UIAlertController(title: "Error", message:"Please, try to log out again!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)}
            
        }
        task.resume()
    }
    func someHandler(alert: UIAlertAction!) {
       self.performSegue(withIdentifier: "mainViewSegue", sender: self)
    }
    
    

    @IBOutlet var welcomeLabel: UILabel!
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Welcome ",Parameters.user.name)
        if Parameters.user.name != "" {
            welcomeLabel.text = "Welcome, "+Parameters.user.name
        }
        else{welcomeLabel.text = "Welcome"}
       
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
