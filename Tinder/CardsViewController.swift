//
//  CardsViewController.swift
//  Tinder
//
//  Created by Jason Zhou on 10/8/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
var initialCenter: CGPoint?

class CardsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: DraggableImageView!
    
    @IBAction func onPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("began pan")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("panning")
            profileImageView.center = CGPoint(x: point.x, y: point.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("ended")
            profileImageView.center = initialCenter!
        }
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("ProfileSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = UIImage(named: "ryan")
        initialCenter = profileImageView.center
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? ProfileViewController
        vc?.imageName = "ryan"
    }
    
    
}

