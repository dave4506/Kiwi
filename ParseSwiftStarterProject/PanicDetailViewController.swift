//
//  PanicDetailViewController.swift
//  Kiwi
//
//  Created by Karan Mehta on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class PanicDetailViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var panicButton: UIButton!
    @IBOutlet var panicDetail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        panicButton.layer.cornerRadius = 6
        panicDetail.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panicButtonPressed() {
        
        //send text data to parse
        print(panicDetail.text)
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView.text == "Enter a description of the panic."){
            textView.text = ""
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
