//
//  MemberDetailsViewController.swift
//  Homely
//
//  Created by Jason Zhou on 10/16/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import AssetsLibrary

class MemberDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {

    var delegate: ImageSelectedDelegate?
    var member: Member?
    var ageRestriction: AgeRestriction?
    var add : Bool = false
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ageLevelSegmentedControl: UISegmentedControl!
    
    @IBAction func onClose(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if add {
            profileImageView?.image = UIImage(named: "new_member")
            saveButton.setTitle("Add", forState: UIControlState.Normal)
        } else {
            saveButton.setTitle("Update", forState: UIControlState.Normal)
            profileImageView.image = member?.profileImage
            nameTextField.text = member?.name
            titleTextField.text = member?.title
            ageRestriction = member?.ageRestriction
        }
        setAgeLevelSegment()
    }

    override func viewWillAppear(animated: Bool) {
        self.startKeyboardObserver()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.stopKeyboardObserver()
    }
    
    
    private func startKeyboardObserver(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil) //WillShow and not Did ;) The View will run animated and smooth
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    private func stopKeyboardObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize =    userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size {
                let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height,  0.0);
                
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
                
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0 + keyboardSize.height) //set zero instead self.scrollView.contentOffset.y
                
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize =  userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size {
                let contentInset = UIEdgeInsetsZero;
                
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: UISegmentedControl) {
        switch ageLevelSegmentedControl.selectedSegmentIndex {
        case 0:
            ageRestriction = AgeRestriction.kid
        case 1:
            ageRestriction = AgeRestriction.youth
        case 2:
            ageRestriction = AgeRestriction.adult
        case 3:
            ageRestriction = AgeRestriction.senior
        default:
            ageRestriction = AgeRestriction.kid
        }
    }
    
    func setAgeLevelSegment() {
        if ageRestriction == nil {
            ageRestriction = AgeRestriction.kid
        }
        switch (ageRestriction!) {
        case AgeRestriction.kid:
            ageLevelSegmentedControl.selectedSegmentIndex = 0
        case AgeRestriction.youth:
            ageLevelSegmentedControl.selectedSegmentIndex = 1
        case AgeRestriction.adult:
            ageLevelSegmentedControl.selectedSegmentIndex = 2
        case AgeRestriction.senior:
            ageLevelSegmentedControl.selectedSegmentIndex = 3
        }
    }
        
    @IBAction func onClick(sender: UIButton) {
        print("Button Clicked")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(vc, animated: true, completion: nil)
        } else {            
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSave(sender: AnyObject) {
        var member: Member
        member = Member(name: nameTextField.text!, title: titleTextField.text!, ageRestriction: self.ageRestriction!, profileImage: self.profileImageView.image!)
        delegate?.onUpdate!(member)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // uncomment the following to save the selected image.
            // also the path is needed if we want to store the profile picture in the cloud.
            //let imageData = UIImageJPEGRepresentation(editedImage, 0.6)
            //let compressedJPGImage = UIImage(data: imageData!)
            //ALAssetsLibrary().writeImageToSavedPhotosAlbum(compressedJPGImage!.CGImage, orientation: ALAssetOrientation(rawValue: compressedJPGImage!.imageOrientation.rawValue)!,
            //    completionBlock:{ (path:NSURL!, error:NSError!) -> Void in
            //        print("\(path)")  //Here you will get your path
            //})
            //NSLog("image picked")
            //delegate?.onImageSelected!(editedImage)
            
            picker.dismissViewControllerAnimated(true) { () -> Void in
                //self.performSegueWithIdentifier("maptolocation", sender: self)
                // send it whereever you want...
                self.profileImageView.image = editedImage
            }
            
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
