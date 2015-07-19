//
//  ProfileViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate ,UIActionSheetDelegate{

    @IBOutlet var coverPic:UIImageView!
    @IBOutlet var profilePic:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var file: PFFile = PFUser.currentUser()!["profilepic"] as! PFFile;
        file.getDataInBackgroundWithBlock {
            (imageData: NSData?,error : NSError?) -> Void in
            if let imageData = imageData{
                self.profilePic.image = UIImage(data: imageData)
            }
        }

        
        // Do any additional setup after loading the view.
    }
    @IBAction func changeProPic(sender: AnyObject) {
        var ActionSheet = UIActionSheet(title: "Image", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle:nil, otherButtonTitles: "Take a picture")
        ActionSheet.addButtonWithTitle("Choose a picture")
        ActionSheet.delegate = self
        ActionSheet.showInView(self.view)
        
    }
    func actionSheet(myActionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int){
        if buttonIndex == 1 {
            ShouldStartCamera(self, true)
        }
        if buttonIndex == 2 {
            ShouldStartPhotoLibrary(self, true)
        }
    }
    @IBAction func changeCovPic(sender: AnyObject) {
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.profilePic.image = image;
        var file = PFFile(name: "picture.jpeg", data: UIImageJPEGRepresentation(image, 0.6));
        var user = PFUser.currentUser()!
        user["profilepic"] = file;
        user.saveInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            ProgressHUD.showSuccess(nil)
            if error != nil {
                ProgressHUD.showError("Problem Connecting!")
            }
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
