//
//  JoinTeamViewController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class JoinTeamViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectView: UICollectionView!
    var arr:NSMutableArray = []
    @IBOutlet weak var Needs: UILabel!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var Team: UILabel!
    var id = ""
    @IBOutlet var requestToJoinButton: UIButton!
    
    @IBAction func requestAction(sender: AnyObject) {
        ProgressHUD.show(nil)
        requestToJoinButton.backgroundColor = UIColor.grayColor()
        PFUser.currentUser()!["request"] = true;
        PFUser.currentUser()!.saveInBackground()
        var obj = PFObject(className: "request")
        obj["user"] = PFUser.currentUser()!
        obj["team"] = self.Team.text
        obj.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                ProgressHUD.showSuccess(nil)
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)

                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    override func viewDidLoad() {
        println("HERES")
        super.viewDidLoad()
        collectView.delegate = self
        collectView.dataSource = self
        requestToJoinButton.layer.cornerRadius = 23
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser()!["team"] as! String != "" || PFUser.currentUser()!["request"] as! Bool != true {
            requestToJoinButton.titleLabel?.text = "Sorry! You already have a team!"
            requestToJoinButton.backgroundColor = UIColor.grayColor()
        }
        setup()
    }
    func setup() {
        var query = PFQuery(className: "Team")
        println(id)
        
        query.whereKey("objectId", equalTo: id)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                println("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                if let object = object {
                    self.Team.text = object["name"] as! String
                    self.Description.text = object["Description"] as! String
                    var array = object["needs"] as! NSMutableArray
                    var all = "";
                    for str in array {
                        all += str as! String
                    }
                    self.Needs.text = all
                }
                println("Successfully retrieved the object.")
                
                self.arr = []
                var query1 = PFQuery(className: "_User")
                query1.whereKey("team", containsString: self.Team.text)
                query1.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        // The find succeeded.
                        println("Successfully retrieved \(objects!.count).")
                        // Do something with the found objects
                        if let objects = objects as? [PFObject] {
                            for object in objects {
                                self.arr.addObject(object)
                            }
                        }
                        self.collectView.reloadData()

                        
                    } else {
                        // Log details of the failure
                        println("Error: \(error!) \(error!.userInfo!)")
                    }
                }
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
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! JoinTeamCollectionViewCell
        
        cell.profilePic.layer.cornerRadius = 45
        var obj = arr[indexPath.row]
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
        cell.profilePic.clipsToBounds = true
        return cell
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
