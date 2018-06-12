//
//  OrderInfoCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 06.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class OrderInfoCell: UITableViewCell {

    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
