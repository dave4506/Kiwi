//
//  signUp1ViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class signUp1ViewController: UIViewController {
 
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var email: IsaoTextField!
    @IBOutlet weak var userName: IsaoTextField!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.hidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
