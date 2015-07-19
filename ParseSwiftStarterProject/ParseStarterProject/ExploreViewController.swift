//
//  ExploreViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

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
    @IBAction func joinButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func exploreButtonPressed(sender: AnyObject) {
        
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
