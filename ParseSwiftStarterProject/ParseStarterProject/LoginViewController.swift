//
//  LoginViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var password: IsaoTextField!
    @IBOutlet weak var username: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func login(sender: AnyObject) {
        ProgressHUD.show("Please Wait...", interaction: false)
        
        PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                ProgressHUD.showSuccess("Login is Valid!")
                if PFUser.currentUser()!["attending"] != nil {
                    self.performSegueWithIdentifier("hack", sender: self)
                }else{
                    self.performSegueWithIdentifier("loginisgood", sender: self)
                }
            } else {
                ProgressHUD.showError("Login Invalid.")
            }
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
