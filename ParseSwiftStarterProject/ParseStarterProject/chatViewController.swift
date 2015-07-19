//
//  chatViewController.swift
//  Kiwi
//
//  Created by Dav Sun on 7/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class chatViewController: JSQMessagesViewController {
    
    // *** STEP 1: STORE FIREBASE REFERENCES
    var fire: Firebase!
    var roomId = "55446546789"
    var users = [] as NSMutableArray
    var messages = [] as NSMutableArray
    var avatars = Dictionary<String, JSQMessagesAvatarImage>()
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1))
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 248/255, green: 101/255, blue: 89/255, alpha: 1))
    var senderImageUrl: String!
    var batchMessages = true
    var ref: Firebase!
    var username = "HEssY"
        
        // *** STEP 1: STORE FIREBASE REFERENCES
        var messagesRef: Firebase!
        
        func setupFirebase() {
            // *** STEP 2: SETUP FIREBASE
            self.senderId = username
            self.senderDisplayName = username
            messagesRef = Firebase(url: "https://kiwichatting.firebaseio.com/rooms/"+roomId)
            
            // *** STEP 4: RECEIVE MESSAGES FROM FIREBASE (limited to latest 25 messages)
            messagesRef.queryLimitedToLast(25).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
                let text = snapshot.value["text"] as? String
                let sender = snapshot.value["sender"] as? String
                let imageUrl = snapshot.value["imageUrl"] as? String
                
                var mess = JSQMessage(senderId: sender, senderDisplayName: sender, date: NSDate(), text:text)
                self.messages.addObject(mess)
                self.finishReceivingMessage()
            })
        }
        
        func sendMessage(text: String!, sender: String!) {
            // *** STEP 3: ADD A MESSAGE TO FIREBASE
            messagesRef.childByAutoId().setValue([
                "text":text,
                "sender":sender
                ])
        }
        
        func tempSendMessage(text: String!, sender: String!) {
            let message = Message(text: text, sender: sender, imageUrl: senderImageUrl)
            messages.addObject(message)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            automaticallyScrollsToMostRecentMessage = true
            setupFirebase()
            self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
            self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
        }
        
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            collectionView.collectionViewLayout.springinessEnabled = true
        }
        
        override func viewWillDisappear(animated: Bool) {
            super.viewWillDisappear(animated)
            
            if ref != nil {
                ref.unauth()
            }
        }
        
        // ACTIONS
        
        func receivedMessagePressed(sender: UIBarButtonItem) {
            // Simulate reciving message
            showTypingIndicator = !showTypingIndicator
            scrollToBottomAnimated(true)
        }
        override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
            JSQSystemSoundPlayer.jsq_playMessageSentSound()
            sendMessage(text, sender: senderId)
            
            finishSendingMessage()
        }
        
        override func didPressAccessoryButton(sender: UIButton!) {
            println("Camera pressed!")
        }
        
        override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
            return messages[indexPath.item] as! JSQMessageData
        }
        

    
        override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
            var message = messages[indexPath.item]
            if message.senderId() == self.username {
                return self.outgoingBubbleImageView
            }
            return self.incomingBubbleImageView
        }
    
        override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
            return nil
        }
    
    
        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return messages.count
        }
        
        override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
            
            let message = messages[indexPath.item]
            if message.senderId() == username {
                cell.textView.textColor = UIColor.blackColor()
            } else {
                cell.textView.textColor = UIColor.whiteColor()
            }
            
            let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView.textColor, NSUnderlineStyleAttributeName: 1]
            cell.textView.linkTextAttributes = attributes
            
            //        cell.textView.linkTextAttributes = [NSForegroundColorAttributeName: cell.textView.textColor,
            //            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle]
            return cell
        }
        
        
        // View  usernames above bubbles
        override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
            let message = messages[indexPath.item];
            
            // Sent by me, skip
            if message.senderId() == username {
                return nil;
            }
            
            // Same as previous sender, skip
            if indexPath.item > 0 {
                let previousMessage = messages[indexPath.item - 1];
                if previousMessage.senderId() == message.senderId() {
                    return nil;
                }
            }
            
            return NSAttributedString(string:message.senderId())
        }
        
        override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
            let message = messages[indexPath.item]
            
            // Sent by me, skip
            if message.senderId() == username {
                return CGFloat(0.0);
            }
            
            // Same as previous sender, skip
            if indexPath.item > 0 {
                let previousMessage = messages[indexPath.item - 1];
                if previousMessage.senderId() == message.senderId() {
                    return CGFloat(0.0);
                }
            }
            
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
}
/*
let main = UIStoryboard(name: "chatStoryBoard", bundle: nil)
let vc = main.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
self.showViewController(vc, sender: self)
*/