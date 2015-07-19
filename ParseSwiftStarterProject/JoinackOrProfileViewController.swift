//
//  JoinackOrProfileViewController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class JoinackOrProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfilePressed() {
        let main = UIStoryboard(name: "Profile", bundle: nil)
        let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
        self.showViewController(vc, sender: self)
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
