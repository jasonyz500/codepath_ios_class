//
//  TaskCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/10/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var doneImageView: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues() {
        taskNameLabel.text = task!.name
        timeLeftLabel.text = "Fri"
//        timeLeftLabel.text = task!.endDateString
        switch task!.taskStatus {
        case .tostart:
            doneImageView.image = UIImage(named: "past_due")
        case .inprogress:
            doneImageView.image = UIImage(named: "pending")
        case .done:
            doneImageView.image = UIImage(named: "check")
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
