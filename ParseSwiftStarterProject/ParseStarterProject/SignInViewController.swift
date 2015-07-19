//
//  SignInViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var confirmTextField: IsaoTextField!
    @IBOutlet weak var passwordTextField: IsaoTextField!
    @IBOutlet weak var usernameTextField: IsaoTextField!
    @IBOutlet weak var emailTextField: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signIn(sender: AnyObject) {
        ProgressHUD.show("Please Wait...", interaction: false)
        var user:PFUser = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.username = usernameTextField.text
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                ProgressHUD.showError("Sign Up Invalid.")
                // Show the errorString somewhere and let the user try again.
            } else {
                ProgressHUD.showSuccess("Sign Up is Valid!")
                self.performSegueWithIdentifier("signupisgood", sender: nil)
                
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
