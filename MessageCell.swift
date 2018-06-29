//
//  MessageCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 11.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate  {
public var messages:NSMutableArray=[]
    override func awakeFromNib() {
        self.tableView.delegate = self
        // tableView.bounces = true
        tableView.isScrollEnabled = true
        tableView.dataSource = self;
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var tableView: UITableView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "messageItemCell", for: indexPath) as! MessageItemCell
        let mess = messages[indexPath.row] as! Orderprocess
        cell.labelDate.text = mess.when
        cell.labelMessage.text = mess.description
        
        //cell.textLabel?.text = array[indexPath.row] as? String;
        return cell
    }


}
