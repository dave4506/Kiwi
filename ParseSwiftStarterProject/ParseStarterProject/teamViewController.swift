//
//  teamViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse
class teamViewController: UIViewController {

    @IBOutlet weak var Create: UIButton!
    @IBOutlet weak var team: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profile: UIImageView!
    override func viewDidLoad() {

        team.layer.cornerRadius = 25;
        Create.layer.cornerRadius = 25;
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func JoinTeam(sender: AnyObject) {
        let main = UIStoryboard(name: "TeamPeople", bundle: nil)
        let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
        self.showViewController(vc, sender: self)
    }
    @IBAction func profileAction(sender: AnyObject) {
        let main = UIStoryboard(name: "Profile", bundle: nil)
        let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
        self.showViewController(vc, sender: self)
    }
    @IBAction func SignOut(sender: AnyObject) {
        PFUser.logOut();
        self.navigationController?.popToRootViewControllerAnimated(true)
        ProgressHUD.showSuccess(nil)    }
    override func viewWillAppear(animated: Bool) {
        self.loadHack()
    }
    func loadHack(){
        var query = PFQuery(className: "Hackathon")
        query.whereKey("objectId", equalTo: PFUser.currentUser()!["attending"] as! String)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                println("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                println("Successfully retrieved the object.")
                if let object = object {
                    self.name.text = object["name"] as! String
                    let userImageFile = object["image"] as! PFFile
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let imageData = imageData {
                                let image = UIImage(data:imageData)
                                self.profile.image = image;
                                self.profile.layer.cornerRadius = 64
                                self.profile.clipsToBounds = true
                            }
                        }
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
