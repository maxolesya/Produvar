//
//  UpdateStatusCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 19.06.2018.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class UpdateStatusCell: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    public var status:NSMutableArray=[]

    @IBOutlet var picker: UIPickerView!
    
    
    
    override func awakeFromNib() {
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        super.awakeFromNib()
        // Initialization code
    }
    
 
    @IBAction func updateClick(_ sender: Any) {
        if (locationView.text?.isEmpty)! {
            let alert = UIAlertController(title: "Thank you!", message: "You subscribed successfully", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            
            //present(alert, animated: true, completion: nil)
            return
        }
        else{
            updateStatus(url:"https://prodapp.000webhostapp.com/orderstatusupdate")
            
        }
    }
    @IBOutlet var locationView: UITextField!
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return status.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (status[row] as! Workflowstep).status
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
        
    }
    
    func updateStatus(url:String) {
        var request = URLRequest(url: NSURL(string: "https://prodapp.000webhostapp.com/orderstatusupdate")! as URL)
        request.httpMethod = "POST"
        request.addValue("Bearer "+Parameters.user.bearer, forHTTPHeaderField: "Authorization")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue(Parameters.token, forHTTPHeaderField: "token")
        // request.addValue(Parameters.language, forHTTPHeaderField: "lang")
        
        var body: [String: AnyObject]
        body = ["code": Parameters.orderCode  as AnyObject,"currentStatus": "" as AnyObject, "newStatus":"" as AnyObject,"who":locationView.text as AnyObject]
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
                        
                       // self.present(alert, animated: true, completion: nil)
                        return}
                    
                    
                }
                else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Thank you!", message: "You subscribed successfully", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(defaultAction)
                        
                       // self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
            task.resume()
        }
        catch{}
        
        
    }
   
    
    
}
