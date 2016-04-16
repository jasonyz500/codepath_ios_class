//
//  TweetsViewController.swift
//  twitter
//
//  Created by Jason Zhou on 9/27/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate, TweetDetailsDelegate {
    
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        getData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TABLE VIEW FNS
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = self.tweets![indexPath.row]
        cell.setValues()
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // DELEGATE
    func tweetCell(tweetCell: TweetCell, action: String) {
        switch action {
        case "reply":
            print("reply triggered from main page")
            self.performSegueWithIdentifier("ComposeSegue", sender: tweetCell)
        case "retweet":
            print("retweet triggered from main page")
        case "favorite":
            print("favorite triggered from main page")
            self.tweets![tableView.indexPathForCell(tweetCell)!.row] = tweetCell.tweet!
        case "profile":
            print("pressed profile")
            self.performSegueWithIdentifier("homeToProfileSegue", sender: tweetCell)
        default:
            print("error")
        }
    }
    
    func tweetDetails(tweetDetails: TweetDetailsViewController) {
        self.tweets![tweetDetails.index] = tweetDetails.tweet
        // toggle favorite icon
        self.tableView.reloadData()
    }
    
    // ACTIONS
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func getData() {
        TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    func onRefresh() {
        getData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destinationViewController.title == "Tweet" {
            let vc = segue.destinationViewController as? TweetDetailsViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            vc!.tweet = self.tweets![indexPath!.row]
            vc!.index = indexPath!.row
            vc!.delegate = self
        } else if segue.identifier == "ComposeSegue" {
            let vc = segue.destinationViewController as? ComposeViewController
            if sender is TweetCell {
                vc!.tweet = sender!.tweet
            }
        } else {
            let vc = segue.destinationViewController as? ProfileViewController
            vc!.user = sender!.tweet!.user
        }
    }
    
}
