//
//  KeyboardViewController.swift
//  UnknownKeyboard
//
//  Created by g-2016 on 2014/10/16.
//  Copyright (c) 2014年 g-2016. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    @IBOutlet var nextKeyboardButton: CustomButton!
    @IBOutlet var shiftButton:CustomButton!
    var buttons = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","!","z","x","c","v","b","n","m","?"]
    var shift = false

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
        
    override func viewDidAppear(animated: Bool) {
        
        //ボタン作成
        for var i = 0;i < buttons.count;i++ {
            var button = self.makeButton(i)
            self.view.addSubview(button)
        }
        
        //削除ボタン作成
        self.setDeleteButton()
        
        //スペースボタン
        self.setSpaceButton()
        
        //キーボード切り替え
        self.changeKeyboard()
        
        //改行ボタン
        self.setBreakButton()
        
        //shiftボタン
        self.setShiftButton()
        

    }
    
    //ボタン作成
    func makeButton(num:NSInteger) -> CustomButton {
        var buttonImage = UIImage(named: "201\(buttons[num])")
        var button = CustomButton.buttonWithType(.Custom) as CustomButton
        var buttonSize = CGSizeMake(28,40)
        var xy = self.setPlace(num)
        
        button.setTitle("", forState: .Normal)
        button.addTarget(self, action: "input:", forControlEvents:.TouchUpInside)
        button.frame.size = buttonSize
        button.frame.origin = CGPointMake(xy.0 * 31 + self.view.frame.size.width / 2,xy.1 * 50 + 15)
        button.setImage(buttonImage, forState: .Normal)
        button.tag = num

        return button
    }
    
    func setPlace(num:NSInteger) -> (CGFloat,CGFloat){
        let numF = CGFloat(num)
        switch numF {
        case 0...9:
            return (numF-5,0)
        case 10...19:
            return (numF-15,1)
        default:
            return (numF-25,2)
        }
    }
    
    //削除ボタン作成
    func setDeleteButton(){
        var deleteButton = CustomButton.buttonWithType(.System) as CustomButton
        deleteButton.setTitle("Delete", forState: .Normal)
        deleteButton.frame = CGRectMake(258, 117, 60, 36)
        deleteButton.addTarget(self, action: "deleteText:", forControlEvents: .TouchUpInside)
        deleteButton.tintColor = .redColor()
        self.view.addSubview(deleteButton)
        
    }
    
    //Shift
    func setShiftButton(){
        var buttonImage = UIImage(named: "132")
        shiftButton = CustomButton.buttonWithType(.Custom) as CustomButton
        shiftButton.setTitle("", forState: .Normal)
        shiftButton.setImage(buttonImage, forState: .Normal)
        shiftButton.frame = CGRectMake(5, 170, 40, 36)
        shiftButton.addTarget(self, action: "shiftChange:", forControlEvents: .TouchUpInside)
        self.view.addSubview(shiftButton)
    }
    
    //スペースボタン
    func setSpaceButton(){
        var spaceButton = CustomButton.buttonWithType(.System) as CustomButton
        spaceButton.setTitle("Space", forState: .Normal)
        spaceButton.frame = CGRectMake(115, 170, 124, 36)
        spaceButton.addTarget(self, action: "insertSpace:", forControlEvents: .TouchUpInside)
        self.view.addSubview(spaceButton)
    }
    
    //改行ボタン作成
    func setBreakButton(){
        var breakButton = CustomButton.buttonWithType(.System) as CustomButton
        breakButton.setTitle("⏎", forState: .Normal)
        breakButton.frame = CGRectMake(250, 170, 60, 36)
        breakButton.addTarget(self, action: "insertLine:", forControlEvents: .TouchUpInside)
        self.view.addSubview(breakButton)
    }
    
    //キーボード切り替えボタン
    func changeKeyboard(){
        self.nextKeyboardButton = CustomButton.buttonWithType(.System) as CustomButton
        self.nextKeyboardButton.setTitle("Next", forState: .Normal)
        self.nextKeyboardButton.frame = CGRectMake(56, 170, 50, 36)
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        
    }
    
    //入力
    func input(sender:AnyObject) {
        var proxy = self.textDocumentProxy as UIKeyInput
        if shift {
            proxy.insertText(buttons[sender.tag].uppercaseString)
            //proxy.insertText(buttonsShift[sender.tag])
            shift = false
            shiftButton.backgroundColor = .whiteColor()
        }else {
            proxy.insertText(buttons[sender.tag])
        }
    }
    //スペース
    func insertSpace(sender:AnyObject){
        var proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText(" ")
    }
    
    //改行
    func insertLine(sender:AnyObject){
        var proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText("\n")
    }
    
    //削除
    func deleteText(sender:AnyObject) {
        var proxy = self.textDocumentProxy as UIKeyInput
        proxy.deleteBackward()
    }
    
    //shift
    func shiftChange(sender:AnyObject){
        if shift {
            shift = false
            shiftButton.backgroundColor = .whiteColor()
        }else {
            shift = true
            shiftButton.backgroundColor = .grayColor()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        if self.nextKeyboardButton != nil {
            self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
        }
    }

   }
