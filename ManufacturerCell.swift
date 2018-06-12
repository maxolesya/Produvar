//
//  ManufacturerCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 06.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class ManufacturerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var mailLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var manufLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
