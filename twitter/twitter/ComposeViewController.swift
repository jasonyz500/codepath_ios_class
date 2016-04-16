//
//  ComposeViewController.swift
//  twitter
//
//  Created by Jason Zhou on 9/28/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = User.currentUser?.name
        screenNameLabel.text = User.currentUser?.screenname
        profileImageVIew.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!))
        if self.tweet != nil {
            self.textField.text = "@\((self.tweet!.user?.screenname)! )"
        }
        self.textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressTweet(sender: AnyObject) {
        var params : [String:String] = NSDictionary() as! [String:String]
        params["status"] = textField.text
        if self.tweet != nil {
            params["in_reply_to_status_id"] = self.tweet!.id
        }
        TwitterClient.sharedInstance.tweetWithParams(params, completion: {(response, error) -> () in
            if error != nil {
                print("error publishing tweet")
            } else {
                print("successfully published tweet")
                self.performSegueWithIdentifier("OnTweetSegue", sender: self)
            }
        })
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
