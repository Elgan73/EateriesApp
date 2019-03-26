//
//  EateriesTableViewCell.swift
//  EateriesApp
//
//  Created by Dev Apps4Selling on 08/01/2019.
//  Copyright © 2019 Dev Apps4Selling. All rights reserved.
//

import UIKit

class EateriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
