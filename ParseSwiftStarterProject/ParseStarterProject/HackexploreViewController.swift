//
//  HackexploreViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class HackexploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var searchButton: UIButton!
    var search = false;
    var arr = NSMutableArray();
    var name = ""
    var file = PFFile()
    var hours = 0;
    @IBOutlet weak var collectView: UICollectionView!
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var goto:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectView.delegate = self
        self.collectView.dataSource = self
        self.collectView.alwaysBounceVertical = true
        var query = PFQuery(className: "Hackathon")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
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
        // Do any additional setup after loading the view.
    }


    @IBAction func search(sender: AnyObject) {
        
        if search == false {
            arr = [];
            let alertController = UIAlertController(title: "Search", message: nil, preferredStyle: .Alert)
            
            let changeAction = UIAlertAction(title: "Search", style: .Default) { (_) in
                let loginTextField = alertController.textFields![0] as! UITextField
                if loginTextField.text != "" {
                    var word = loginTextField.text.lowercaseString
                    var query = PFQuery(className: "Hackathon")
                    query.whereKey("lowercase", containsString: word)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            println("Successfully retrieved \(objects!.count) scores.")
                            // Do something with the found objects
                            if let objects = objects as? [PFObject] {
                                for object in objects {
                                    self.arr.addObject(object)
                                }
                            }
                            self.searchButton.titleLabel!.text = "Cancel"
                            self.search = true;
                            self.collectView.reloadData()
                        } else {
                            // Log details of the failure
                            println("Error: \(error!) \(error!.userInfo!)")
                        }
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { (_) in }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "Search Hacks"
            }
            alertController.addAction(changeAction)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)

        } else {
            arr = [];
            var query = PFQuery(className: "Hackathon")
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            self.arr.addObject(object)
                        }
                    }
                    self.searchButton.titleLabel!.text = "Search"
                    self.search = false;
                    self.collectView.reloadData()
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo!)")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HackCollectionViewCell
        var obj = arr[indexPath.row] as! PFObject
        
        cell.name.text = obj["name"] as! String
        cell.location.text = obj["location"] as! String
        let startDate:NSDate = NSDate()
        let endDate:NSDate = obj.createdAt!
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        hours = obj["Hours"] as! Int
        let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: nil)
        cell.date.text = "\(components.day) days till"
        
        let userImageFile = obj["image"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.image.image = image
                }
            }
        }
        //cell.image.image = UIImage(named: "kiwi")
        cell.image.layer.cornerRadius = 39;
        cell.image.clipsToBounds = true
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var obj = arr[indexPath.row] as! PFObject
        goto = obj.objectId!
        name = obj["name"] as! String
        file = obj["image"] as! PFFile

        self.performSegueWithIdentifier("hack", sender: self)
        
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hack" {
            let vc:hackViewController = segue.destinationViewController as! hackViewController
            vc.hackId = self.goto
            vc.names = self.name
            vc.file = self.file
            vc.Hour = "\(self.hours)"
        }
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
