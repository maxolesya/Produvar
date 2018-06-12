//
//  MessageItemCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 11.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class MessageItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var labelMessage: UILabel!
    @IBOutlet var labelDate: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
