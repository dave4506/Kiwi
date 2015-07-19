//
//  createTeamViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
class creatTeamViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}