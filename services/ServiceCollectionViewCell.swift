//
//  ServiceCollectionViewCell.swift
//  services
//
//  Created by Akhlaq Rao on 9/24/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.clear
        //let screenWidth = UIScreen.main.bounds.size.width
        //widthConstraint.constant = screenWidth - (2 * 12)
    }
}
