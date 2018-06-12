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
    public var step:NSMutableArray=[]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return step.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "statusItemCell", for: indexPath) as! StatusItemCell
        if status[indexPath.row] as! String == "in process" {
            cell
        }
       //cell.textLabel?.text = array[indexPath.row] as? String;
        return cell
    }

}
