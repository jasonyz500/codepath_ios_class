//
//  Task.swift
//  Homely
//
//  Created by Jason Zhou on 10/10/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

enum TaskStatus {
    case tostart, inprogress, done
}

class Task: NSObject {
    var name : String = ""
    var taskDescription: String = ""
    var startDateString : String = ""
    var endDateString : String = ""
    var parentChoreId : Int = -1
    var taskStatus: TaskStatus = TaskStatus.tostart
    var assignee: Member?
    
    init(name: String, taskDescription: String, status: TaskStatus, startDateString: String, endDateString: String, parentChoreId: Int) {
        self.name = name
        self.taskDescription = taskDescription
        self.startDateString = startDateString
        self.endDateString = endDateString
        self.parentChoreId = parentChoreId
        self.taskStatus = status
    }
}

