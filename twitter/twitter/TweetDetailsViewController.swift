//
//  TweetDetailsViewController.swift
//  twitter
//
//  Created by Jason Zhou on 9/27/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

@objc protocol TweetDetailsDelegate {
    optional func tweetDetails(tweetDetails: TweetDetailsViewController)
}

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    var index: Int!
    var delegate: TweetDetailsDelegate?
    
    @IBAction func onPressMenuReply(sender: AnyObject) {
        onReply(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenname
        tweetTextLabel.text = tweet.text
        timestampLabel.text = tweet.createdAtString
        favoritesLabel.text = String(tweet.favorites!)
        retweetsLabel.text = String(tweet.retweets!)
        profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
        if (tweet.isFavorite != nil) {
            if tweet.isFavorite! {
                favoriteImage.image = UIImage(named: "favorite_on")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
        print("Press Reply")
        self.performSegueWithIdentifier("ReplySegue", sender: self)
    }
    @IBAction func onRetweet(sender: AnyObject) {
        print("Press retweet")
        TwitterClient.sharedInstance.retweet(tweet!.id) { (response, error) -> () in
            print("retweeted")
        }
    }
    @IBAction func onFavorite(sender: AnyObject) {
        if tweet!.isFavorite! {
            favoriteImage.image = UIImage(named: "favorite")
        } else {
            favoriteImage.image = UIImage(named: "favorite_on")
        }
        TwitterClient.sharedInstance.toggleTweetFavorite(tweet!.id, favorite_on: tweet!.isFavorite, completion: { (response, error) -> () in
            if error == nil {
                print("toggled tweet")
                if self.tweet!.isFavorite != nil {
                    self.tweet!.isFavorite! = !self.tweet!.isFavorite!
                }
                self.delegate?.tweetDetails!(self)
            } else {
                print("error toggling tweet!")
            }
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? ComposeViewController
        vc!.tweet = sender!.tweet
    }


}
