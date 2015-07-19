//
//  hackViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class hackViewController: UIViewController {
    
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var attending: UILabel!
    @IBOutlet weak var Hours: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    var hackId:String = ""
    var file:PFFile = PFFile()
    var names = ""
    var Hour = "";
    @IBOutlet weak var GoingAction: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        self.setUpProfile()
        self.name.text = names
        self.Hours.text = Hour
        var query = PFQuery(className: "Hackathon")
        query.getFirstObjectInBackgroundWithBlock {
            (obj: PFObject?, error: NSError?) -> Void in
            if error != nil || obj == nil {
                println("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                if let obj = obj {
                    self.address.text = obj["Address"] as! String
                    self.date.text = obj["Date"] as! String
                    self.url.text = obj["Url"] as! String
                }
                println("Successfully retrieved the object.")
            }
        }
        self.GoingAction.layer.cornerRadius = 23;
        self.GoingAction.layer.borderWidth = 1;
    }
    
    
    
    func setUpProfile(){
        file.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.picture.image = image
                }
            }
        }
        picture.layer.cornerRadius = 50;
        picture.clipsToBounds = true
        picture.layer.borderWidth = 1
        var q1 = PFQuery(className: "_User")
        q1.whereKey("attending", equalTo: hackId)
        q1.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.attending.text = "\(objects.count)"
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        var q2 = PFQuery(className: "Team")
        q2.whereKey("attending", equalTo: hackId)
        q2.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    self.team.text = "\(objects.count)"
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }

    }
}