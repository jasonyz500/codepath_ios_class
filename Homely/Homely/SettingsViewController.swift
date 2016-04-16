//
//  SettingsViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/15/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import Parse

@objc protocol ImageSelectedDelegate {
    optional func onUpdate(member: Member)
    optional func onImageSelected(image: UIImage)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImageSelectedDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var chores: [Chore]?
    var homeName:String = "john2 home"
    var members: [Member]?
    var currentndexPath: NSIndexPath?
    var add: Bool? = false
    var parseClient:ParseClient!
    
    func initChoreList() {
        chores = [Chore]()
        let query = PFQuery(className:"Chore")
        query.whereKey("home", equalTo:homeName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) chores.")
                // Do something with the found objects
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        var name = object["name"] as! String
                        var description = object["description"] as! String
                        var ageRestriction = AgeRestriction(rawValue: object["ageRestriction"] as! String)!
                        var diffculty = Difficulty(rawValue: object["difficulty"] as! String)!
                        var chore = Chore(name: name, desc: name, difficulty: diffculty, ageRestrictions: [ageRestriction])
                        self.chores?.append(chore)
                        print("new chore fetched")
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
          self.tableView.reloadData()
        }
        
        
//        chores?.append(Chore(name: "Pickup Trash", desc: "Cover living room and kitchen", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "1 load laundry - wash, dry, fold", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.tue))
//        chores?.append(Chore(name: "Wash dishes", desc: "No dishwasher allowed!", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Scrub Kitchen Sink", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.mon))
//        chores?.append(Chore(name: "Wipe Kitchen Counter", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sat))
//        chores?.append(Chore(name: "Wash Kitchen Table", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Wash bathroom sinks and counters", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Scrub toilets", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Clean tub / shower", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Dust Tables, TV tops", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Vacuum Carpets", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Grocery Shopping", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.sun))
//        chores?.append(Chore(name: "Clean out fridge", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.mon))
//        chores?.append(Chore(name: "Clean Oven", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.fri))
//        chores?.append(Chore(name: "Make beds", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.thu))
//        chores?.append(Chore(name: "Wash sheets", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior], recurrenceDeadline: RecurrenceDeadline.wed))

    }
    
    func initMemberList() {
        members = [Member]()
        
        let query = PFQuery(className:"Member")
        query.whereKey("home", equalTo:homeName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        var pImage = object["profileImage"] as! PFFile
                        var name = object["name"] as! String
                        var title = object["title"] as! String
                        var ageRestriction = AgeRestriction(rawValue: object["ageRestriction"] as! String)!
                        var profileImage = UIImage(data: try!pImage.getData())!
                        var member = Member(name:name, title:title, ageRestriction: ageRestriction, profileImage:profileImage)
                        self.members?.append(member)
                        self.tableView.reloadData()
                        print("new member fetched")
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
        //members?.append(Member(name: "John", title: "Dad", ageRestriction: AgeRestriction.adult, profileImage: UIImage(named: "JF")!))
        //members?.append(Member(name: "Deepa", title: "Mom", ageRestriction: AgeRestriction.adult, profileImage: UIImage(named: "DF")!))
        //members?.append(Member(name: "Josh", title: "Son", ageRestriction: AgeRestriction.youth, profileImage: UIImage(named: "JoshF")!))
        //members?.append(Member(name: "Esther", title: "Daughter", ageRestriction: AgeRestriction.kid, profileImage: UIImage(named: "EF")!))
        //members?.append(Member(name: "Usha", title: "Gramma", ageRestriction: AgeRestriction.senior, profileImage: UIImage(named: "GM")!))
        
    }
    
    @IBAction func onSchedule(sender: UIBarButtonItem) {
        print("Pressed Schedule")
    }
    
    @IBAction func onLogout(sender: UIBarButtonItem) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        dismissViewControllerAnimated(true, completion: nil)
        self.storyboard?.instantiateInitialViewController()
    }
    
    @IBAction func onPressSchedule(sender: UIButton) {
        print("Pressed Schedule")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.registerNib(UINib(nibName: "ChoreCell", bundle: nil), forCellReuseIdentifier: "ChoreCell")
        tableView.registerNib(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.registerNib(UINib(nibName: "SectionHeaderCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderCell")
        tableView.registerNib(UINib(nibName: "MemberCell", bundle: nil), forCellReuseIdentifier: "MemberCell")
        initChoreList()
        initMemberList()
        parseClient=ParseClient()
        getData()
    }
    
    // TABLE VIEW FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            // return 5
            return self.members?.count ?? 0
        case 2:
            return self.chores?.count ?? 0
        default:
            return 0
        }
    }
    
    func setMemberCellData(cell: MemberCell, member: Member) {
        let name = member.name
        let title = member.title
        let ageRestriction = member.ageRestriction
        cell.profileNameLabel.text = "\(name), \(title), \(ageRestriction)"
        cell.profileImageView.image = member.profileImage
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderCell
            cell.headerImageView.image = UIImage(named: "Home")
            cell.profileImageView.image = UIImage(named: "")
            //        cell.Chore = self.chores![indexPath.row]
            //        cell.setValues()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("MemberCell", forIndexPath: indexPath) as! MemberCell
            setMemberCellData(cell, member: (members?[indexPath.row])!)
//            switch indexPath.row {
//            case 0:
//                cell.profileImageView.image = UIImage(named: "JF")
//            case 1:
//                cell.profileImageView.image = UIImage(named: "DF")
//            case 2:
//                cell.profileImageView.image = UIImage(named: "JoshF")
//            case 3:
//                cell.profileImageView.image = UIImage(named: "EF")
//            case 4:
//                cell.profileImageView.image = UIImage(named: "GM")
//            default:
//                cell.profileImageView.image = UIImage(named: "ryan")
//            }
//            if (indexPath.row % 2) == 0 {
//                cell.backgroundColor = UIColor(rgb:0xDAFFED)
//            } else {
//                cell.backgroundColor = UIColor(rgb:0x9BF3F0)
//            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("ChoreCell", forIndexPath: indexPath) as! ChoreCell
            cell.chore = chores![indexPath.row]
            cell.setValues()
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ChoreCell", forIndexPath: indexPath) as! ChoreCell
            //        cell.Chore = self.chores![indexPath.row]
            //        cell.setValues()
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section {
        case 1:
            currentndexPath = indexPath
            add = false
            self.performSegueWithIdentifier("MemberDetailsSegue", sender: self)
        case 2:
            self.performSegueWithIdentifier("ChoreDetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        default:
            break
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 1 && section != 2 {
            return nil
        }
        let header = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
        header.addImageView.image = UIImage(named: "add139")
        let headerTapRecognizer = UITapGestureRecognizer()
        if section == 1 {
            header.headerLabel.text = "Family"
            headerTapRecognizer.addTarget(self, action: "didTapAddMember")
            header.addImageView.addGestureRecognizer(headerTapRecognizer)
        } else {
            header.headerLabel.text = "Tasks"
            headerTapRecognizer.addTarget(self, action: "didTapAddChore")
            header.addImageView.addGestureRecognizer(headerTapRecognizer)
        }
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1, 2:
            return 30
        default:
            return 0
        }
    }
    
    func didTapAddMember() {
        print("tapped add member")
        add = true
        self.performSegueWithIdentifier("MemberDetailsSegue", sender: self)
        
    }
    
    func didTapAddChore() {
        print("tapped add Chore")
        self.performSegueWithIdentifier("ChoreDetailsSegue", sender: self)
    }
    
    func onImageSelected(image: UIImage) {
        let cell = tableView.cellForRowAtIndexPath(currentndexPath!) as! MemberCell
        cell.profileImageView.image = image
    }
    
    func onUpdate(member: Member) {
        if (add! == true) {
            addMemberAndRefresh(member)
        } else {
            let cell = tableView.cellForRowAtIndexPath(currentndexPath!) as! MemberCell
            setMemberCellData(cell, member: member)
        }
    }
    
    func addMemberAndRefresh(member: Member) {
        print(member.name, member.title, member.ageRestriction.description)
        var imageData = UIImageJPEGRepresentation(member.profileImage, 0.1)
        let pimageFile = PFFile(data: imageData!)
        parseClient!.addMemberToHome("john2 home", name: member.name, title: member.title, ageRestriction: member.ageRestriction.description, profileImage: pimageFile!)
        members?.append(member)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        //        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
        //            self.tweets = tweets
        //            self.tableView.reloadData()
        //        })
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MemberDetailsSegue" {
            let destVC = segue.destinationViewController as! MemberDetailsViewController
            destVC.delegate = self
            // let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            if let indexPath = currentndexPath {
                let cell = tableView.cellForRowAtIndexPath(currentndexPath!) as! MemberCell
                destVC.member = members?[indexPath.row]
            }
            destVC.add = add!
        } else if segue.identifier == "ChoreDetailsSegue" {
            let destVC = (segue.destinationViewController as! UINavigationController).topViewController as! ChoreDetailsViewController
            if sender!.isMemberOfClass(ChoreCell) {
                destVC.chore = self.chores![(tableView.indexPathForCell(sender as! UITableViewCell)?.row)!]
            } else {
                destVC.chore = Chore(name: "", desc: "", difficulty: Difficulty.easy, ageRestrictions: [AgeRestriction.kid, AgeRestriction.youth, AgeRestriction.adult, AgeRestriction.senior])
            }

        }
    }


}
