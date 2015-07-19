//
//  SearchViewController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Parse
import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var id = ""
    @IBOutlet weak var teams: UIButton!
    @IBOutlet weak var hackers: UIButton!
    @IBOutlet weak var textField: IsaoTextField!
    var classname = "_User"
    var arr:NSMutableArray = [];
    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet var searchTextField: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        self.loadAll()
        // Do any additional setup after loading the view.
    }

    @IBAction func search(sender: AnyObject) {
        searchAll()
    }
    @IBAction func hackerAction(sender: AnyObject) {
        classname = "_User"
        hackers.titleLabel?.textColor = UIColor.blackColor()
        teams.titleLabel?.textColor = UIColor.grayColor()
        searchAll()
    }
    @IBAction func teamAction(sender: AnyObject) {
        classname = "Team"
        teams.titleLabel?.textColor = UIColor.blackColor()
        hackers.titleLabel?.textColor = UIColor.grayColor()
        searchAll()
    }
    func loadAll(){
        arr = []
        var query = PFQuery(className: classname)
        query.whereKey("attending", equalTo: PFUser.currentUser()!["attending"] as! String)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        if self.classname == "_User" {
                            if object.objectId != PFUser.currentUser()!.objectId {
                                self.arr.addObject(object)
                            }
                        }
                        if self.classname == "Team" {
                            var team = object["members"] as! NSArray
                            if team.containsObject(PFUser.currentUser()!.username!) == true {
                                self.arr.addObject(object)
                            }
                        }
                    }
                    self.searchCollectionView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var obj = arr[indexPath.row] as! PFObject
        id = obj.objectId!
        self.performSegueWithIdentifier("team", sender: self)
    }
    func searchAll(){
        arr = []
        var query = PFQuery(className: classname)
        if self.classname == "_User" {
            query.whereKey("username", containsString: textField.text)
        }else{
            query.whereKey("name", containsString: textField.text)
        }
        query.whereKey("attending", equalTo: PFUser.currentUser()!["attending"] as! String)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        if self.classname == "_User" {
                            if object.objectId != PFUser.currentUser()!.objectId {
                                self.arr.addObject(object)
                            }
                        }
                        if self.classname == "Team" {
                            var team = object["members"] as! NSArray
                            if team.containsObject(PFUser.currentUser()!.username!) == false {
                                self.arr.addObject(object)
                            }
                        }
                    }
                }
                self.searchCollectionView.reloadData()

            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return arr.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! SearchCandidateCollectionViewCell
        cell.profilePic.layer.cornerRadius = 45
        var obj = arr[indexPath.row]
        if self.classname == "_User" {
            var array = obj["Skills"] as! NSMutableArray
            var all = "";
            for str in array {
                all += str as! String
            }
            cell.skills.text = all
            cell.name.text = obj["username"] as! String
            var userImageFile = obj["profilepic"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.profilePic.image = image
                    }
                }
            }
        } else {
            var userImageFile = obj["image"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.profilePic.image = image
                    }
                }
            }
            cell.name.text = obj["name"] as! String
            var array = obj["needs"] as! NSMutableArray
            var all = "";
            for str in array {
                all += str as! String
            }
            cell.skills.text = all
        }
        cell.profilePic.clipsToBounds = true
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "team" {
            let vc:JoinTeamViewController = segue.destinationViewController as! JoinTeamViewController
            vc.id = self.id
        }
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
