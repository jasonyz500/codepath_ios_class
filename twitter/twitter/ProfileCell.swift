//
//  ProfileCell.swift
//  twitter
//
//  Created by Jason Zhou on 10/5/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    var user: User?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues() {
        nameLabel.text = user?.name
        userNameLabel.text = "@\((user?.screenname)!)"
        let profileImageUrl = NSURL(string: (user?.profileImageUrl)!)
        profileImageView.setImageWithURL(profileImageUrl)
        self.tweetsLabel.text = String((user?.tweets)!)
        print(String((user?.tweets)!))
        self.followersLabel.text = String((user?.followers)!)
        followingLabel.text = String((user?.following!)!)
    }
}
