//
//  TaskDetailsViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/10/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ChoreDetailsViewController: UITableViewController {
    
    var chore: Chore?
    var parseClient:ParseClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseClient = ParseClient()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "onSave")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "onCancel")
        //tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func onSave() {
        print("Triggered save chore")
        var home = "john2 home"
        var description = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! ChoreDescriptionCell).taskDescriptionTextView.text
        print("Description: \(description)")
        var name = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ChoreNameCell).taskNameTextField.text
        var difficulty = self.chore?.difficulty
        var ageRestriction = self.chore?.ageRestrictions[0]

        parseClient?.addChoreToHome(home, name: name!, description: description!, difficulty: (difficulty?.description)!, ageRestriction: (ageRestriction?.description)!)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func onCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("ChoreNameCell", forIndexPath: indexPath) as! ChoreNameCell
            cell.taskNameTextField.text = self.chore?.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("ChoreDescriptionCell", forIndexPath: indexPath) as! ChoreDescriptionCell
            cell.taskDescriptionTextView.text = self.chore?.choreDescription
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("SelectionCell", forIndexPath: indexPath) as! SelectionCell
            cell.optionNameLabel.text = "Difficulty Level"
            cell.optionValueLabel.text = self.chore?.difficulty.description
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SelectionCell", forIndexPath: indexPath) as! SelectionCell
            cell.optionNameLabel.text = "Age Restriction"
            return cell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
