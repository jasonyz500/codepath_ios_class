//
//  HomeViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/9/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import KYCircularProgress

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

class BaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tasks: [Task]?
    
    func initTaskList() {
        tasks = [Task]()
        tasks?.append(Task(name: "Pickup Trash", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "1 load laundry - wash, dry, fold", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Wash dishes", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Scrub Kitchen Sink", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Wipe Kitchen Counter", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Wash Kitchen Table", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Wash bathroom sinks and counters", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Scrub toilets", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Clean tub / shower", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Dust Tables, TV tops", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Vacuum Carpets", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Grocery Shopping", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Clean out fridge", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Clean Oven", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Make beds", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))
        tasks?.append(Task(name: "Wash sheets", taskDescription: "placeholder", status: TaskStatus.tostart, startDateString: "2015-10-01", endDateString: "2015-10-05", parentChoreId: -1))

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTaskList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TABLE VIEW FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
            // return self.tasks?.count ?? 0
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderCell
            let vc = self.navigationController?.topViewController
            if (vc!.isKindOfClass(HomeViewController)) {
                cell.profileImageView.hidden = true
            }
            
            //        cell.task = self.tasks![indexPath.row]
            //        cell.setValues()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("ProgressCell", forIndexPath: indexPath) as! ProgressCell
            return cell
        case 2:
            let vc = self.navigationController?.topViewController
            if (vc!.isKindOfClass(HomeViewController)) {
                let cell = tableView.dequeueReusableCellWithIdentifier("TaskCellWithPhoto", forIndexPath: indexPath) as! TaskCellWithPhoto
                if (indexPath.row % 3 == 0) {
                    cell.doneImageView.image = UIImage(named: "check")
                    let t = tasks?[Int.random(0...15)]
                    cell.taskNameLabel.text = t?.name
                    cell.memberImageView.image = UIImage(named: "JF")
                    
                } else if (indexPath.row % 2 == 0) {
                    cell.doneImageView.image = UIImage(named: "past_due")
                    let t = tasks?[Int.random(0...15)]
                    cell.taskNameLabel.text = t?.name
                    cell.memberImageView.image = UIImage(named: "JoshF")
                } else {
                    cell.doneImageView.image = UIImage(named: "pending");
                    let t = tasks?[Int.random(0...15)]
                    cell.taskNameLabel.text = t?.name
                    cell.memberImageView.image = UIImage(named: "EF")
                }
                //        cell.task = self.tasks![indexPath.row]
                //        cell.setValues()
                
                return cell

            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell
                cell.task = self.tasks![indexPath.row]
                cell.setValues()
                return cell

            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell
            //        cell.task = self.tasks![indexPath.row]
            //        cell.setValues()
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 2 {
            self.performSegueWithIdentifier("TaskDetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))   
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let header = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
            //header.headerLabel.text = section == 2 ? "Pending Tasks" : "Complete Tasks"
            header.headerLabel.text = "Tasks"
            header.headerLabel.textColor = UIColor(rgb: 0x9BBEC7)
            header.backgroundColor = UIColor(rgb: 0x251605)
            return header
        default:
            return nil
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        case 2, 3:
            return 30
        default:
            return 0
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigatio

    
}
