//
//  Tweet.swift
//  twitter
//
//  Created by Jason Zhou on 9/27/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorites: Int?
    var retweets: Int?
    var isFavorite: Bool?
    var id: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        favorites = dictionary["favorite_count"] as? Int
        retweets = dictionary["retweet_count"] as? Int
        self.isFavorite = dictionary["favorited"] as? Bool
        
        if favorites == nil {
            favorites = 0
        }
        if retweets == nil {
            retweets = 0
        }
        id = dictionary["id_str"] as? String
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
