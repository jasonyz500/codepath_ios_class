//
//  OutlookViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/15/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class OutlookViewController: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.registerNib(UINib(nibName: "TaskCellWithPhoto", bundle: nil), forCellReuseIdentifier: "TaskCellWithPhoto")
        tableView.registerNib(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        tableView.registerNib(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.registerNib(UINib(nibName: "SectionHeaderCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderCell")
        tableView.registerNib(UINib(nibName: "ProgressCell", bundle: nil), forCellReuseIdentifier: "ProgressCell")
        self.navigationController?.title = "My Tasks"
        
        getData()
    }

    @IBAction func onLogout(sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        dismissViewControllerAnimated(true, completion: nil)
        self.storyboard?.instantiateInitialViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        //        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
        //            self.tweets = tweets
        //            self.tableView.reloadData()
        //        })
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = (segue.destinationViewController as! UINavigationController).topViewController as! TaskDetailsViewController
        vc.task = self.tasks![(tableView.indexPathForCell(sender as! UITableViewCell)?.row)!]
    }

}
