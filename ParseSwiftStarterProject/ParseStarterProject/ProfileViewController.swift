//
//  ProfileViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate ,UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var occupation: IsaoTextField!
    @IBOutlet weak var fullName: IsaoTextField!
    @IBOutlet var profilePic: UIImageView!
    var skills = ["None","iOS Dev", "Web Dev", "Full Stack Dev","Front End Dev", "Backend Dev","Designer","Android Dev","Algorithms"]
    var skillToAdd = ""
    var skillArray:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadStuff()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveData(sender: AnyObject) {
        let userNow = PFUser.currentUser()!
        userNow["Name"] = fullName.text
        userNow["Occu"] = occupation.text
        userNow["Skills"] = skillArray as NSArray
        userNow.saveInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            ProgressHUD.showSuccess(nil)
            if error != nil {
                ProgressHUD.showError("Problem Connecting!")
            }
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        self.loadStuff()
    }
    func loadStuff(){
        let userMan = PFUser.currentUser()!
        if(userMan["Name"] != nil){
            fullName.text = PFUser.currentUser()!["Name"] as! String
        }
        if(userMan["Occu"] != nil){
            occupation.text = PFUser.currentUser()!["Occu"] as! String
        }
        /*
        if(userMan["Skills"] != nil){
            let dic = userMan["Skills"] as! NSArray
            for var i = 0; i < dic.count; i++ {
                skil.text = skil.text! + "\(dic[i]),"
            }
        }
*/
        if(userMan["profilepic"] == nil){
            profilePic.image = UIImage(contentsOfFile: "prof.jpg")
            self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
            self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
            self.profilePic.layer.borderWidth = 5
            self.profilePic.clipsToBounds = true
        }
        else {
            let userImageFile = PFUser.currentUser()!["profilepic"] as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.profilePic.image = image
                        self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
                        self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
                        self.profilePic.layer.borderWidth = 5
                        self.profilePic.clipsToBounds = true
                    }
                }else{
                    println(error)
                }
            }
        }
        
        
        
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
        
        //self.profilePic.image = image;
        var file = PFFile(name: "picture.jpeg", data: UIImageJPEGRepresentation(image, 0.6));
        self.profilePic.image = file as? UIImage
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SkillTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SkillTableViewCell
        if(cell.switchButton.on == true){
            skillArray.addObject((cell.skill.text as String?)!)
            
        }
        if (indexPath.row == 0){
            cell.skill.text = "iOS Developer"
            cell.switchButton.setOn(false, animated: true)
        }
        if (indexPath.row == 1){
            cell.skill.text = "Web Developer"
            cell.switchButton.setOn(false, animated: true)
        }
        if (indexPath.row == 2){
            cell.skill.text = "Back End Developer"
            cell.switchButton.setOn(false, animated: true)
        }
        
        return cell
    }
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:SkillTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SkillTableViewCell
        let userNow = PFUser.currentUser()!
        switch (indexPath.row) {
            case 0:
                cell.switchButton.setOn(true, animated: true)
            
            
            case 1:
                cell.switchButton.setOn(true, animated: true)
                userNow["Skills"]?.addObject("iOS Dev")
            default:
                println("Default")
        }
        userNow.saveInBackground()
        
    }
    */
    // returns the # of rows in each component..
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
