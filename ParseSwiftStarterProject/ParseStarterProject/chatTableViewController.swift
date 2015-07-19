//
//  chatTableViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class chatTableViewController: UIViewController,UIActionSheetDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("profile") as! chatViewCell
        cell.profilePic.layer.borderWidth = 1;
        cell.profilePic.layer.borderColor = UIColor.blackColor().CGColor!
        cell.profilePic.layer.cornerRadius = 30
        cell.contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
}