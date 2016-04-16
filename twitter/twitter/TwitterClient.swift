//
//  TwitterClient.swift
//  twitter
//
//  Created by Jason Zhou on 9/27/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

let twitterConsumerKey = ""
let twitterConsumerSecret = ""
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
        }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failed")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        //get tweets
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("Error getting user")
            completion(tweets: nil, error: error)
        })
    }
    
    func tweetWithParams(params: NSDictionary?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let rdict = response as! NSDictionary
            completion(response: rdict, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error posting tweet!")
                completion(response: nil, error: error)
        })
    }
    
    func toggleTweetFavorite(id: String?, favorite_on: Bool?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        var endpoint = ""
        if favorite_on == nil || !favorite_on! {
            endpoint = "1.1/favorites/create.json?id=\(id!)"
        } else {
            endpoint = "1.1/favorites/destroy.json?id=\(id!)"
        }
        POST(endpoint, parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let rdict = response as! NSDictionary
            completion(response: rdict, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error toggling tweet favorite!")
                completion(response: nil, error: error)
        })
    }
    
    func retweet(id: String?, completion: (response: NSDictionary?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id!).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let rdict = response as! NSDictionary
            completion(response: rdict, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error retweeting!")
                completion(response: nil, error: error)
        })
    }
    
    func userTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        //get tweets
        GET("1.1/statuses/user_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error getting user")
                completion(tweets: nil, error: error)
        })
    }
    
    func mentionsTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        //get tweets
        GET("1.1/statuses/mentions_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error getting user")
                completion(tweets: nil, error: error)
        })
    }
    
    func userWithParams(params: NSDictionary?, completion: (user: User?, error: NSError?) -> ()) {
        GET("1.1/users/show.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let user = User(dictionary: response as! NSDictionary)
            completion(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error getting user")
                completion(user: nil, error: error)
        })
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //get user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error getting user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
}
