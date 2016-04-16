//
//  ParseClient.swift
//  Homely
//
//  Created by Anand Gupta on 10/17/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import Parse

class ParseClient: NSObject {
    func getObectByName(identifierKey:String, identifierValue:String, objectName:String) -> PFObject? {
        var pfobject:PFObject?
        let query = PFQuery(className:objectName)
        query.whereKey(identifierKey, equalTo:identifierValue)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(object) home.")
                // Do something with the found objects
                if let object = object as? PFObject? {
                    pfobject=object
                }
            }
            else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return pfobject
    }
    
    func getFilteredObectByName(identifierKey:String, identifierValue:String, objectName:String) -> PFObject? {
        var pfobject:PFObject?
        let query = PFQuery(className:objectName)
        query.whereKey(identifierKey, equalTo:identifierValue)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(object) home.")
                // Do something with the found objects
                if let object = object as? PFObject? {
                    pfobject=object
                }
            }
            else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return pfobject
    }
    
    func createHome(name:String) -> PFObject? {
        var home = getObectByName("name", identifierValue: name, objectName: "home")
        if (home == nil) {
            let newhome = PFObject(className:"Home")
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
        
    func addMemberToHome(home:String, name:String, title:String, ageRestriction:String, profileImage:PFFile){
        
        //print("getting home")
        //var home = getObectByName("name", identifierValue: home, objectName: "Home")
        //if (home == nil){
        //    print("home was fetched as nil")
        //}
        
        //print("home fetched")
        
        let newMemeber = PFObject(className:"Member")
        newMemeber["name"] = name
        newMemeber["title"] = title
        newMemeber["ageRestriction"] = ageRestriction
        newMemeber["home"] = home
        newMemeber["profileImage"] = profileImage
        newMemeber.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("New Member was created")
            } else {
                print("New Member couldn\'t be added")
            }
        }
    }
    
    func addChoreToHome(home:String, name:String, description:String, difficulty:String, ageRestriction:String){
        let newChore = PFObject(className:"Chore")
        newChore["home"] = home
        newChore["name"] = name
        newChore["description"] = description
        newChore["difficulty"] = difficulty
        newChore["ageRestriction"] = ageRestriction
        newChore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("New Chore was added")
            } else {
                print("New Chore couldn\'t be added")
            }
        }
    }
    
    func createJobForMember(homeName:String, memberName:String, choreName:String){
        var home = getObectByName("name", identifierValue:homeName, objectName: "home")
        var member = getObectByName("name", identifierValue:memberName, objectName: "member")
    }

}




