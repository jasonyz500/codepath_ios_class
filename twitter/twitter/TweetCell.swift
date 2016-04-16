//
//  TweetCell.swift
//  twitter
//
//  Created by Jason Zhou on 9/27/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
    optional func tweetCell(tweetCell: TweetCell, action: String)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: TweetCellDelegate?
    var tweet: Tweet?
    
    @IBAction func onPressReply(sender: AnyObject) {
        delegate?.tweetCell!(self, action: "reply")
    }
    
    @IBAction func onPressRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!.id) { (response, error) -> () in
            print("retweeted")
        }
        delegate?.tweetCell!(self, action: "retweet")
    }

    @IBAction func onPressFavorite(sender: AnyObject) {
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
                self.delegate?.tweetCell!(self, action: "favorite")
            } else {
                print("error toggling tweet!")
            }
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setValues() {
        nameLabel.text = tweet!.user?.name
        screenNameLabel.text = "@\((tweet!.user?.screenname)!)"
        let profileImageUrl = NSURL(string: (tweet!.user?.profileImageUrl)!)
        profileImageView.setImageWithURL(profileImageUrl)
        tweetTextLabel.text = tweet!.text
        if (tweet!.isFavorite != nil) && tweet!.isFavorite! {
            favoriteImage.image = UIImage(named: "favorite_on")
        } else {
            favoriteImage.image = UIImage(named: "favorite")
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onCustomTap:")
        self.profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func onCustomTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.tweetCell!(self, action: "profile")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
