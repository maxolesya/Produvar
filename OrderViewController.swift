//
//  OrderViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 02.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        postSearchByScan(b: NSMutableArray())

       // tableView.delegate = self
         self.tableView.delegate = self
        // tableView.bounces = true
        tableView.isScrollEnabled = true
        tableView.dataSource = self;
      //  super.viewDidLoad()
  //      super.reloadInputViews()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_ =  UITableViewCell()
        if true {
            if indexPath.row==0 {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "manufacturerCell", for: indexPath) as! ManufacturerCell
                
                cell.phoneLabel.text = "+79256410156"
                cell.mailLabel.text = "info@evolveproduction.nl"
                cell.websiteLabel.text = "https://www.evolveproductions.nl"
                cell.nameLabel.text = "Evolve Productions B.V"
                cell.manufLabel.text = "Manufacturer"
                cell_=cell
            }
            if indexPath.row==1 {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "orderInfoCell", for: indexPath) as! OrderInfoCell
                
                cell.nameLabel.text = "Worktop X34 for Johnson Family"
                cell.dueDateLabel.text = "2018-07-29 12:12"
                cell_=cell
            }
            if indexPath.row==2{
              
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemsCell
                cell.array.add("items2" )
                cell.array.add("items3")
                cell.array.add("items4" )
                cell.array.add("items5" )
                cell.array.add("items6" )
                cell.array.add("items7")
                cell.tableView.reloadData()
              

                cell_=cell
            }

            
        }
        
        return cell_
    }


   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func postSearchByScan(b:NSMutableArray) {
        let username = "mark@facebook.com"
        let password = "facebook"
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        print(loginData)
        // create the request
        let url = URL(string: "https://prodapp.000webhostapp.com/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        //making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // check status code returned by the http server
                print("response = \(response)")
                print("status code = \(httpStatus.statusCode)")
                // process result
            }
             self.tableView.reloadData()
        }
        task.resume()
        
        
        
         /*request = URLRequest(url: NSURL(string: "https://prodapp.000webhostapp.com/searchbyscan")! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var body: [String:String]
        body = ["code": "4fn34rqfrefk" as String,"url": "https://facebook.com" as String]
        print(body)
        do {
            
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil { // обработка ошибки при отправке
                    
                    print("error=\(error)")
                    
                    return
                    
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                
                print("responseString = \(responseString)")
                
                if((responseString.contains("Bad")) ) {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error!", message: "Something is wrong!", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        
                        self.present(alert, animated: true, completion: nil)
                        return}
                    
                    
                }
                else {
                    DispatchQueue.main.async {
                        print(responseString)
                        let alert = UIAlertController(title: "Thank you!", message: "You subscribed successfully", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
            task.resume()
        }
        catch{}*/
        
        
        
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
