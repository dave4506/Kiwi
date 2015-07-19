//
//  ExploreViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ExploreViewController: UIViewController {

    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.update.layer.cornerRadius = 27
        self.update.layer.borderWidth = 0.5
        self.update.layer.borderColor = UIColor.blueColor().CGColor!
        
        self.joinButton.layer.cornerRadius = 27
        self.joinButton.layer.borderWidth = 0.5
        self.joinButton.layer.borderColor = UIColor.blueColor().CGColor!
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser()!["attending"] != nil {
            self.performSegueWithIdentifier("hack", sender: self)
        }
    }
    @IBAction func joinButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func exploreButtonPressed(sender: AnyObject) {
        let main = UIStoryboard(name: "Profile", bundle: nil)
        let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
        self.showViewController(vc, sender: self)
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
