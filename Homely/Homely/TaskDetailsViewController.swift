//
//  TaskDetailsViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/19/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    var task: Task?

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!

    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    


    @IBAction func onPressCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onPressSave(sender: UIBarButtonItem) {
        print("Pressed save task")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.taskNameLabel.text = self.task!.name
        self.taskDescriptionLabel.text = self.task!.taskDescription
        self.dueDateLabel.text = "Due: \(self.task!.endDateString)"
        switch self.task!.taskStatus {
        case .tostart:
            self.statusSegmentedControl.selectedSegmentIndex = 0
        case .inprogress:
            self.statusSegmentedControl.selectedSegmentIndex = 1
        case .done:
            self.statusSegmentedControl.selectedSegmentIndex = 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
