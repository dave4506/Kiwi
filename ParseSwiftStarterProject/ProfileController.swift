//
//  ProfileController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: 1400)
        
        scrollView.addSubview(containerView)
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
