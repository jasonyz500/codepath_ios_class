//
//  ProfileViewController.swift
//  twitter
//
//  Created by Jason Zhou on 10/5/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        getData()
        if let user = self.user {
            if user.screenname == User.currentUser?.screenname {
                // update the nav controller
                let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout:")
                self.navigationItem.leftBarButtonItem = logoutButton
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.user = self.user
            cell.setValues()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            cell.tweet = self.tweets![indexPath.row]
            cell.setValues()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if self.tweets != nil {
                return self.tweets!.count
            } else {
                return 0
            }
        } else if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData() {
        if self.user == nil {
            self.user = User.currentUser
        }
        let params = NSMutableDictionary()
        params["screen_name"] = self.user?.screenname
        TwitterClient.sharedInstance.userTimelineWithParams(params, completion: {(tweets, error) -> () in
            self.tweets = tweets
            TwitterClient.sharedInstance.userWithParams(params, completion: {(user, error) -> () in
                self.user = user
                print("got tweets and user!")
                self.tableView.reloadData()
            })
        })
    }
    
    func logout(sender: AnyObject) {
        User.currentUser?.logout()
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