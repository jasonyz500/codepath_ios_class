//
//  ContainerViewController.swift
//  twitter
//
//  Created by Jason Zhou on 10/5/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

enum SlideOutState {
    case Collapsed
    case Expanded
}

class ContainerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuWidthConstraint: NSLayoutConstraint!
    
    var tweetsViewController:UIViewController?
    var profileViewController:UIViewController?
    var mentionsViewController:UIViewController?
    
    var currentState: SlideOutState = .Collapsed
    var viewControllers:[UIViewController?] = []
    var selectedViewController:UIViewController?
    
    let MAXWIDTH:CGFloat = 150
    
    func selectViewController(viewController:UIViewController) {
        if let existingController = selectedViewController{
            existingController.willMoveToParentViewController(nil)
            existingController.view.removeFromSuperview()
            existingController.removeFromParentViewController()
        }
        self.addChildViewController(viewController)
        viewController.view.frame = self.contentView.bounds
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
        selectedViewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            profileViewController, tweetsViewController, mentionsViewController
        ]
        self.menuWidthConstraint.constant = 0
        self.selectViewController(viewControllers[0]!)

        // Do any additional setup after loading the view.
    }
    
    private func showMenu() {
        UIView .animateWithDuration(0.5, animations: { () -> Void in
            self.menuWidthConstraint.constant = self.MAXWIDTH
        });
    }
    
    private func hideMenu() {
        UIView .animateWithDuration(0.5, animations: { () -> Void in
            self.menuWidthConstraint.constant = 0
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            // if panel was collapsed to begin with
            if currentState == .Collapsed {
                if translation.x > 0 {
                    if translation.x > MAXWIDTH {
                        self.menuWidthConstraint.constant = MAXWIDTH
                    } else {
                        self.menuWidthConstraint.constant = translation.x
                    }
                }
            } else {
                //if panel was expanded to begin with
                if translation.x < 0 {
                    if translation.x < 0-MAXWIDTH {
                        self.menuWidthConstraint.constant = 0
                    } else {
                        self.menuWidthConstraint.constant = MAXWIDTH+translation.x
                    }
                }
            }

        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if currentState == .Collapsed {
                if velocity.x > 10 && translation.x > 10 {
                    showMenu()
                    self.view.layoutIfNeeded()
                    currentState = .Expanded
                } else {
                  self.hideMenu()
                }
            }
            if currentState == .Expanded {
                if velocity.x < -10 && translation.x < -10 {
                    hideMenu()
                    self.view.layoutIfNeeded()
                    currentState = .Collapsed
                } else {
                    showMenu()
                }
            }
        }
    }

    @IBAction func onPressProfile(sender: AnyObject) {
        self.selectViewController(viewControllers[0]!)
        hideMenu()
    }
    @IBAction func onPressHome(sender: AnyObject) {
        self.selectViewController(viewControllers[1]!)
        hideMenu()
    }
    @IBAction func onPressMentions(sender: AnyObject) {
        self.selectViewController(viewControllers[2]!)
        hideMenu()
        
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
