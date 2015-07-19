//
//  PublicProfileController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PublicProfileController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var name: UILabel!
    @IBOutlet var detailsCollection: UICollectionView!
    
    var skills = ["None","iOS Dev", "Web Dev", "Full Stack Dev","Front End Dev", "Backend Dev","Designer","Android Dev","Algorithms"]
    
    var user:PFUser = PFUser()
    
    
    var textArr = ["Wow, he is great!", "I love him!", "He is a great hacker!", "I want to hack with him!"]
    var authorArr = ["David Sun", "Pranav M", "Karan M", "Anish M"]

    @IBOutlet var coverPic: UIImageView!
    @IBOutlet var profilePic: UIImageView!
    override func viewWillAppear(animated: Bool) {
        let userImageFile = user["profilepic"] as! PFFile
        name.text = user["username"] as! String
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.profilePic.image = image
                    self.profilePic.layer.cornerRadius = self.profilePic.frame.height / 2
                    self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
                    self.profilePic.layer.borderWidth = 5
                    self.profilePic.clipsToBounds = true
                }
            }else{
                println(error)
            }
        }
        
        
        
        
        self.detailsCollection.dataSource = self
        self.detailsCollection.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func chatAction(sender: AnyObject) {
        var query = PFQuery(className: "Rooms")
        query.whereKey("users", containsAllObjectsInArray: [PFUser.currentUser()!.username,user.username])
        self.performSegueWithIdentifier("chat", sender: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PublicTextCollectionViewCell
        cell.textMessage.text = textArr[indexPath.row]
        cell.textAuthor.text = authorArr[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
