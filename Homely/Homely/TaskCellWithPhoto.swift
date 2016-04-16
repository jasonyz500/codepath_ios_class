//
//  TaskCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/10/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class TaskCellWithPhoto: UITableViewCell {

    @IBOutlet weak var doneImageView: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var memberImageView: UIImageView!
    
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues() {
//        taskNameLabel.text = task!.name
//        timeLeftLabel.text = (some form of date calculation)
//        if task!.isDone == true {
//            doneImageView.image = UIImage(named: "taskDone")
//        } else {
//            doneImageView.image = UIImage(named: "taskIncomplete")
//        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
