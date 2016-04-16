//
//  HomeViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/9/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import KYCircularProgress
import Parse

class HomeViewController: BaseViewController {
    
//    var tasks: [Task]?
    
    @IBOutlet weak var tableView: UITableView!
    var parseClient:ParseClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseClient = ParseClient()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.registerNib(UINib(nibName: "TaskCellWithPhoto", bundle: nil), forCellReuseIdentifier: "TaskCellWithPhoto")
        tableView.registerNib(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        tableView.registerNib(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.registerNib(UINib(nibName: "SectionHeaderCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderCell")
        tableView.registerNib(UINib(nibName: "ProgressCell", bundle: nil), forCellReuseIdentifier: "ProgressCell")
        
        getData()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        dismissViewControllerAnimated(true, completion: nil)
        self.storyboard?.instantiateInitialViewController()
    }
    
    func getData() {
        
        var homeObj = parseClient.createHome("john home") as PFObject?
        
        //        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
        //            self.tweets = tweets
        //            self.tableView.reloadData()
        //        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = (segue.destinationViewController as! UINavigationController).topViewController as! TaskDetailsViewController
        vc.task = self.tasks![(tableView.indexPathForCell(sender as! UITableViewCell)?.row)!]
    }
    
}
