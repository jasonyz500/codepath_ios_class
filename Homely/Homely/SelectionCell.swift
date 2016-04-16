//
//  SelectionCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/18/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell {

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
