//
//  UIButton+EZExtend.swift
//  medical
//
//  Created by zhuchao on 15/4/22.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit


let NAV_BAR_HEIGHT = CGFloat(40.0)
let NAV_BUTTON_MIN_WIDTH = CGFloat(40.0)
let NAV_BUTTON_MIN_HEIGHT = CGFloat(40.0)

extension UIButton{
    public convenience init(navImage: UIImage){
        var buttonFrame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: navImage.size.width, height: NAV_BAR_HEIGHT)
        if  buttonFrame.size.width < NAV_BUTTON_MIN_WIDTH
        {
            buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH
        }
        if buttonFrame.size.height < NAV_BUTTON_MIN_HEIGHT
        {
            buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT
        }
        self.init(frame:buttonFrame)
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.backgroundColor = UIColor.clear
        self.setImage(navImage, for: UIControlState())
    }
    
    public convenience init(navTitle: String,color: UIColor){
        let titleSize = navTitle.boundingRect(with: CGSize(width: 999999.0, height: NAV_BAR_HEIGHT), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: Dictionary(dictionaryLiteral: (NSFontAttributeName,UIFont.systemFont(ofSize: 16.0))), context: nil).size
        var buttonFrame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: titleSize.width, height: NAV_BAR_HEIGHT)
        if  buttonFrame.size.width < NAV_BUTTON_MIN_WIDTH
        {
            buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH
        }
        if buttonFrame.size.height < NAV_BUTTON_MIN_HEIGHT
        {
            buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT
        }
        self.init(frame: buttonFrame)
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.setTitleColor(color, for: UIControlState())
        self.setTitle(navTitle, for: UIControlState())
    }
    
    public func setBackgroundImageWithColor(_ color: UIColor?, forState state: UIControlState){
        if let c = color {
            let image = UIImage.imageWithColor(c, size: CGSize(width: 1, height: 1))
            self.setBackgroundImage(image, for: state)
        }
    }
}
