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
    var orders:[Order] = []
    var order:Order = Order(label: "", code: "", dueDate: "", items: [], process: [], statusFlow: [])
    override func viewDidLoad() {
       
       processorders(url:"https://prodapp.000webhostapp.com/orders") 
         self.tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.dataSource = self;
       super.viewDidLoad()
        
        var newBackButton = UIBarButtonItem(title:"Back", style: .plain, target: self, action: #selector(self.goBack))
        navigationItem.leftBarButtonItem = newBackButton
       
   
        self.tableView.reloadData()
    }
    func goBack()
    {
        self.performSegue(withIdentifier: "fromOrderToMainSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.count().count+2
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_ =  UITableViewCell()
        if true {
            if indexPath.row == 0 {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "manufacturerCell", for: indexPath) as! ManufacturerCell
                
                cell.phoneLabel.text = Parameters.manufacturer.phonenumber
                cell.mailLabel.text = Parameters.manufacturer.email
                cell.websiteLabel.text = Parameters.manufacturer.website
                cell.nameLabel.text = Parameters.manufacturer.name
                cell.manufLabel.text = "Manufacturer"
                cell_=cell
            }
            if order.count()[indexPath.row] == "dueDate" {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "orderInfoCell", for: indexPath) as! OrderInfoCell
                
                cell.nameLabel.text = order.label
                cell.dueDateLabel.text = order.dueDate
                cell_=cell
            }
            if order.count()[indexPath.row] == "items"{
              
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemsCell
                for  item in order.items {
                cell.array.add(item.label )
                }
                //cell.tableView.reloadData()
                cell_=cell
            }
            if order.count()[indexPath.row] == "statusFlow"{
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "statusFlowCell", for: indexPath) as! StatusFlowCell
                for  item in order.statusFlow {
                    cell.status.add( item)
                 
                }
            
                cell_=cell
            }
            if order.count()[indexPath.row] == "process"{
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "messagesCell", for: indexPath) as! MessageCell
                for  item in order.process {
                    cell.messages.add(item)
                }
                cell.tableView.reloadData()
                
               // cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.tableView.frame.height)
                cell_=cell
            }
            if order.count()[indexPath.row] == "update"{
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "updateStatusCell", for: indexPath) as! UpdateStatusCell
                for  item in order.statusFlow {
                    if item.iscurrent == "false" && item.isfinished == "false" {
                        cell.status.add(item)
                    }
                }
                cell.picker.reloadAllComponents()
                cell_=cell
            }
            
        }
        
        return cell_
    }


   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func processorders(url:String)  {
        if Parameters.orderCode.isEmpty || Parameters.user.bearer.isEmpty  {return}
        print("orders")
        let getString = "?code=" + Parameters.orderCode + "&skip=0&limit=1"
        var request = URLRequest(url: NSURL(string: url+getString)! as URL)
        request.httpMethod = "GET"
        var responseString = ""
        request.setValue("Bearer " + Parameters.user.bearer, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            let httpStatus = response as? HTTPURLResponse
            // Print out response string
            responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as!String
            print("responseString = \(responseString)")
            if (httpStatus?.statusCode == 200){
                print("success")
                do{
                    self.orders = try JSONDecoder().decode([Order].self, from: data!)
                    self.order = self.orders[0]
                    DispatchQueue.main.async {self.tableView.reloadData()}
                    
                }
                catch{
                    print(error)
                    let alert = UIAlertController(title: "Something is wrong in orders!", message:"Check your username, password and try again!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                let alert = UIAlertController(title: "Wrong format!", message:"Make sure you are scanning an appropriate autorization tag", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)}
            
        }
        task.resume()
    }
  /*  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height:CGFloat
        if order.count()[indexPath.row] == "items"{
            
            height =  CGFloat(order.items.count * 200)
        }
        if order.count()[indexPath.row] == "statusFlow"{
            
            height =  CGFloat(order.statusFlow.count * 20)
        }
        if order.count()[indexPath.row] == "process"{
            
            height =  CGFloat(order.process.count * 20)
        }
        else{height = 50}
        return height
        
    }*/
    /*override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 700
        tableView.rowHeight = UITableViewAutomaticDimension
    }*/
  
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
