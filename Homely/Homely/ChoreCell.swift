//
//  ChoreCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/19/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ChoreCell: UITableViewCell {

    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var choreDescriptionLabel: UILabel!
    @IBOutlet weak var choreDeadlineLabel: UILabel!
    
    var chore: Chore?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues() {
        choreNameLabel.text = chore!.name
        choreDescriptionLabel.text = chore!.choreDescription
        choreDeadlineLabel.text = chore!.recurrenceDeadline.description
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
