//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chat(sender: AnyObject) {
        let main = UIStoryboard(name: "chatStoryBoard", bundle: nil)
        let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
        self.showViewController(vc, sender: self)

    }
}

