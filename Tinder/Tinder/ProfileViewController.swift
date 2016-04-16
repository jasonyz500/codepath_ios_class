//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Jason Zhou on 10/8/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = UIImage(named: imageName!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        print("tapp")
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        self.dismissViewControllerAnimated(true, completion: nil)
//        let cardViewController = storyboard.instantiateViewControllerWithIdentifier("CardsViewController")
//        self.presentViewController(cardViewController, animated: true, completion: nil)
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
