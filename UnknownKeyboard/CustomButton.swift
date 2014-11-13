//
//  CustomButton.swift
//  Unknown
//
//  Created by g-2016 on 2014/10/16.
//  Copyright (c) 2014年 g-2016. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8.0
        self.tintColor = .blackColor()
        self.backgroundColor = .whiteColor()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
