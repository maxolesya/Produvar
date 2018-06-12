//
//  ItemsTableViewCell.swift
//  Produvar
//
//  Created by Олеся Максакова on 08.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
               let image = UIImage(named: "icons8-доска-планшет-26.png")
        imageView?.image = image
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
