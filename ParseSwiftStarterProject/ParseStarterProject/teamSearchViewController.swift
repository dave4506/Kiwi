//
//  teamSearchViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//
import Parse
import Foundation

class teamSearchViewController: UIViewController {
    
    var TorN = false
    @IBOutlet weak var createButtonn: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var hackName: UILabel!
    @IBOutlet weak var hackPic: UIImageView!
    override func viewDidLoad() {
        getHackImage()
        self.createButtonn.layer.cornerRadius = 27
        self.joinButton.layer.cornerRadius = 27
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getHackImage(){
        var query = PFQuery(className: "Hackathon")
        query.getObjectInBackgroundWithId(PFUser.currentUser()!["attending"] as! String) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let obj = gameScore {
                self.hackPic.layer.cornerRadius = self.hackPic.frame.height/2;
                self.hackPic.clipsToBounds = true;
                self.hackName.text = obj["name"] as! String
                var file: PFFile = obj["image"] as! PFFile;
                file.getDataInBackgroundWithBlock {
                    (imageData: NSData?,error : NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            self.hackPic.image = UIImage(data: imageData)
                        }
                    } else {
                        println(error)
                        ProgressHUD.showError("Network Error!")
                    }
                }

            }
        }
    }
    
    @IBAction func createAction(sender: AnyObject) {
    
    }
    
    @IBAction func joinAction(sender: AnyObject) {
        self.performSegueWithIdentifier("explore", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "explore" {
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

