//
//  TaskDescriptionCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/19/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ChoreDescriptionCell: UITableViewCell {

    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
