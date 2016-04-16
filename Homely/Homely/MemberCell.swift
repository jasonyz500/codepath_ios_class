//
//  MemberCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/15/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}