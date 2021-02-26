//
//  DishesTableViewCell.swift
//  CookBook
//
//  Created by Lenovo on 23/02/21.
//  Copyright © 2021 Suda gowtham kumar reddy. All rights reserved.
//

import UIKit

class DishesTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImg: UIImageView!
    
    @IBOutlet weak var dishName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
