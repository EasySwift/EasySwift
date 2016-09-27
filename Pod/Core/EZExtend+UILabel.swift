//
//  EZExtend+UILabel.swift
//  medical
//
//  Created by zhuchao on 15/4/28.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
// MARK: - UILabel

private var UILabelAttributedStringArray: UInt8 = 0
extension UILabel {
    
    public var attributedStrings: [NSAttributedString]? {
        get {
            return objc_getAssociatedObject(self, &UILabelAttributedStringArray) as? [NSAttributedString]
        } set (value) {
            objc_setAssociatedObject(self, &UILabelAttributedStringArray, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public  func addAttributedString (_ text: String,
        color: UIColor,
        font: UIFont) {
            let att = NSAttributedString (string: text,
                attributes: [NSFontAttributeName: font,
                    NSForegroundColorAttributeName: color])
            self.addAttributedString(att)
    }
    
    public func addAttributedString (_ attributedString: NSAttributedString) {
        var att: NSMutableAttributedString?
        
        if let a = self.attributedText {
            att = NSMutableAttributedString (attributedString: a)
            att?.append(attributedString)
        } else {
            att = NSMutableAttributedString (attributedString: attributedString)
            attributedStrings = []
        }
        
        attributedStrings?.append(attributedString)
        self.attributedText = NSAttributedString (attributedString: att!)
    }
    
    
    public func updateAttributedStringAtIndex (_ index: Int,
        attributedString: NSAttributedString) {
            
            if (attributedStrings?[index] != nil) {
                attributedStrings?.remove(at: index)
                attributedStrings?.insert(attributedString, at: index)
                
                let updated = NSMutableAttributedString ()
                for att in attributedStrings! {
                    updated.append(att)
                }
                
                self.attributedText = NSAttributedString (attributedString: updated)
            }
    }
    
    public func updateAttributedStringAtIndex (_ index: Int,
        newText: String) {
            if let att = attributedStrings?[index] {
                let newAtt = NSMutableAttributedString (string: newText)
                
                att.enumerateAttributes(in: NSMakeRange(0, att.string.characters.count-1),
                    options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired,
                    using: { (attribute, range, stop) -> Void in
                        for (key, value) in attribute {
                            newAtt.addAttribute(key , value: value, range: range)
                        }
                })
                
                updateAttributedStringAtIndex(index, attributedString: newAtt)
            }
    }
    
    
    public func getEstimatedHeight () -> CGFloat {
        let att = NSAttributedString(string: self.text!, attributes: [NSFontAttributeName:font])
        let rect = att.boundingRect(with: CGSize (width: w, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return rect.height
    }
    
    public func fitHeight () {
        self.h = getEstimatedHeight()
    }
}
