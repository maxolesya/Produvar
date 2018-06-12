//
//  ItemsCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 06.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class ItemsCell: UITableViewCell, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    public var array:NSMutableArray=[]
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        // tableView.delegate = self
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
        return array.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "itCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row] as? String;
        return cell
    }
    


}
