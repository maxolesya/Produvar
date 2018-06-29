//
//  StatusFlowCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 08.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class StatusFlowCell: UITableViewCell, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
 public var status:NSMutableArray=[]
  

    override func awakeFromNib() {
        self.tableView.delegate = self
        // tableView.bounces = true
        tableView.isScrollEnabled = true
        tableView.dataSource = self;
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "statusItemCell", for: indexPath) as! StatusItemCell
        let step = status[indexPath.row] as! Workflowstep
        if step.isfinished == "true" {
            let image = UIImage(named: "icons8-проверено-50.png")
        
            cell.imageView?.image = image
        }
        else if step.iscurrent == "true"   {
            let image = UIImage(named: "icons8-рабочий-процесс-filled-50.png")
            cell.imageView?.image = image
        }
        else{
            let image = UIImage(named: "icons8-спящий-режим-50.png")
            cell.imageView?.image = image
        }
        cell.labelStep.text = step.status
        
       //cell.textLabel?.text = array[indexPath.row] as? String;
        return cell
    }

}
