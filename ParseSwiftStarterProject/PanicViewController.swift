//
//  PanicViewController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class PanicViewController: UIViewController {

    @IBOutlet var panicButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        panicButton.layer.cornerRadius = 130
        panicButton.clipsToBounds = true
        panicButton.layer.borderColor = UIColor.whiteColor().CGColor
        panicButton.layer.borderWidth = 10
        // Do any additional setup after loading the view.
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
