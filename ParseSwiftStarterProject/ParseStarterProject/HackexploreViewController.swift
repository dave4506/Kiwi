//
//  HackexploreViewController.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class HackexploreViewController: UIViewController, UICollectionViewDataSource, , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectView.delegate = self
        collectView.dataSource = self
        collectView.alwaysBounceVertical = true
        // Do any additional setup after loading the view.

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 185, height: 185)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:HackCollectionViewCell = collectView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HackCollectionViewCell
         cell.one.text = "AngleHacks"
        cell.two.text = "Silicon Valley"
        cell.three.text = "2015"
        cell.oneday.text = "Today"
        cell.teamPeople.text = "3 - Teams   9 - People"
        cell.backPic.image = UIImage(contentsOfFile: "angel.jpg")
        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        // 2
        var blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = CGRect(x: -5, y: 0, width: 700, height: 1000)
        // 3
        cell.sheetColor.addSubview(blurView)
        return cell
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
