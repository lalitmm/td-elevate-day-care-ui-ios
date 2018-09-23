//
//  ChildCareTableViewCell.swift
//  services
//
//  Created by Akhlaq Rao on 9/23/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import UIKit

class ChildCareTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var waitList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
