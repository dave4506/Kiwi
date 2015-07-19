//
//  ProfileViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate ,UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var occupation: IsaoTextField!
    @IBOutlet weak var fullName: IsaoTextField!
    @IBOutlet weak var skil: UILabel!
    @IBOutlet var profilePic: UIImageView!
    var skills = ["None","iOS Dev", "Web Dev", "Full Stack Dev","Front End Dev", "Backend Dev","Designer","Android Dev","Algorithms"]
    var skillToAdd = ""
    var skillArray:NSMutableArray = []
    @IBOutlet var skillPicker: UIPickerView!
    @IBOutlet var deleteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteButton.layer.cornerRadius = 6
        self.skillPicker.hidden = true
        self.skillPicker.dataSource = self
        self.skillPicker.delegate = self
        
        self.loadStuff()
        
        self.skillPicker.hidden = false
        
        

        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveData(sender: AnyObject) {
        let userNow = PFUser.currentUser()!
        userNow["Name"] = fullName.text
        userNow["Occu"] = occupation.text
        userNow["Skills"] = skillArray
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
        if(userMan["Skills"] != nil){
            let dic = userMan["Skills"] as! NSArray
            for var i = 0; i < dic.count; i++ {
                skil.text = skil.text! + "\(dic[i]),"
            }
        }
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
    
    @IBAction func deleteButtonPressed() {
        //delete account from parse
        print("delete")
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return skills.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return skills[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skillToAdd = skills[row]
        let userNow = PFUser.currentUser()!
        
        skillArray.addObject(skillToAdd)
        
        //userNow.addObject([skillToAdd], forKey: "Skills")
       
        skil.text = skil.text! + "\(skillToAdd), " as String
        
        //print(skillToAdd)
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
