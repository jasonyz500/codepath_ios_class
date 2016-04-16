//
//  Home.swift
//  Homely
//
//  Created by Anand Gupta on 10/17/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import Parse

class Home: NSObject {
    var name: String?
    var home:PFObject?
    var members:[String]?
    var schedule:String?
    var chore:[String]?
    
    init(name:String){
        super.init()
        self.name = name
        self.home=self.createHome(name)
    }
    
    func createHome(name:String) -> PFObject? {
        var home = getHomeByName(name)
        if (home == nil) {
            var newhome = PFObject(className:"Home")
            newhome["name"] = name
            newhome.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Home was created")
                    home=newhome
                } else {
                    print("Home couldn\'t be created")
                }
            }
        }
        else {
            print("home already exists")
        }
        return home
    }
    
    private func getHomeByName(name:String) -> PFObject? {
        var home:PFObject?
        var query = PFQuery(className:"Home")
        query.whereKey("name", equalTo:name)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(object) home.")
                // Do something with the found objects
                if let object = object as? PFObject? {
                    home=object
                }
            }
            else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return home
    }
    
    
    
}
