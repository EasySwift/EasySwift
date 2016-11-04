//
//  StringFormat.swift
//  Pods
//
//  Created by zhuchao on 15/10/15.
//
//

import Foundation

extension String{
    var viewContentMode:UIViewContentMode{
        var dict = Dictionary<String,UIViewContentMode>()
        dict["ScaleToFill"] = UIViewContentMode.scaleToFill
        dict["ScaleAspectFit"] = UIViewContentMode.scaleAspectFit
        dict["ScaleAspectFill"] = UIViewContentMode.scaleAspectFill
        dict["Redraw"] = UIViewContentMode.redraw
        dict["Center"] = UIViewContentMode.center
        dict["Top"] = UIViewContentMode.top
        dict["Bottom"] = UIViewContentMode.bottom
        dict["Left"] = UIViewContentMode.left
        dict["Right"] = UIViewContentMode.right
        dict["TopLeft"] = UIViewContentMode.topLeft
        dict["TopRight"] = UIViewContentMode.topRight
        dict["BottomLeft"] = UIViewContentMode.bottomLeft
        dict["BottomRight"] = UIViewContentMode.bottomRight
        if let mode = dict[self.trim]{
            return mode
        }else{
            return UIViewContentMode.scaleToFill
        }
    }
    
    var flexContentDirection:FLEXBOXContentDirection{
        switch self.trim {
        case "ltr":
            return .leftToRight
        case "rtl":
            return .rightToLeft
        case "inherit":
            return .inherit
        default:
            return .leftToRight
        }
    }
    
    var justifyContent:FLEXBOXJustification{
        switch self.trim {
        case "center":
            return .center
        case "flex-start":
            return .flexStart
        case "flex-end":
            return .flexEnd
        case "space-between":
            return .spaceBetween
        case "space-around":
            return .spaceAround
        default:
            return .flexStart
        }
    }
    
    var alignItems:FLEXBOXAlignment{
        switch self.trim {
        case "center":
            return .center
        case "flex-start":
            return .flexStart
        case "flex-end":
            return .flexEnd
        case "stretch":
            return .stretch
        case "auto":
            return .auto
        default:
            return .auto
        }
    }
    
    var flexDirection:FLEXBOXFlexDirection{
        switch self.trim {
        case "column":
            return .column
        case "row":
            return .row
        case "row-reverse":
            return .rowReverse
        case "column-reverse":
            return .columnReverse
        default:
            return .row
        }
    }
    
    var separatorStyle:UITableViewCellSeparatorStyle{
        switch self.trim{
        case "None" :
            return .none
        case "SingleLine":
            return .singleLine
        case "SingleLineEtched":
            return .singleLineEtched
        default:
            return .singleLine
        }
    }
    
    var tableViewStyle:UITableViewStyle{
        switch self.trim{
        case "plain":
            return .plain
        case "grouped":
            return .grouped
        default:
            return .plain
        }
    }
    
    var scrollViewIndicatorStyle:UIScrollViewIndicatorStyle{
        switch self.trim{
        case "white":
            return .white
        case "black":
            return .black
        default:
            return .default
        }
    }
    
    var textAlignment:NSTextAlignment {
        switch(self.trim){
        case "center":
            return NSTextAlignment.center
        case "left":
            return NSTextAlignment.left
        case "right":
            return NSTextAlignment.right
        case "justified":
            return NSTextAlignment.justified
        case "natural":
            return NSTextAlignment.natural
        default:
            return NSTextAlignment.left
        }
    }
    
//    var linkStyleDict:[AnyHashable: Any]{
//        let linkArray = self.trimArrayBy(";")
//        var dict = Dictionary<NSObject,AnyObject>()
//        for str in linkArray {
//            var strArray = str.trimArrayBy(":")
//            if strArray.count == 2 {
//                switch strArray[0] {
//                case "color":
//                    dict[kCTForegroundColorAttributeName] = UIColor(css: strArray[1].trim)
//                case "text-decoration":
//                    dict[NSUnderlineStyleAttributeName] = strArray[1].trim.underlineStyle.rawValue
//                default :
//                    dict[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
//                }
//            }
//        }
//        return dict
//    }
    
    
    var keyboardType:UIKeyboardType {
        
        switch self.lowercased() {
        case "Default".lowercased():
            return UIKeyboardType.default
        case "ASCIICapable".lowercased():
            return UIKeyboardType.asciiCapable
        case "NumbersAndPunctuation".lowercased():
            return UIKeyboardType.numbersAndPunctuation
        case "URL".lowercased():
            return UIKeyboardType.URL
        case "NumberPad".lowercased():
            return UIKeyboardType.numberPad
        case "PhonePad".lowercased():
            return UIKeyboardType.phonePad
        case "NamePhonePad".lowercased():
            return UIKeyboardType.namePhonePad
        case "EmailAddress".lowercased():
            return UIKeyboardType.emailAddress
        case "DecimalPad".lowercased():
            return UIKeyboardType.decimalPad
        case "Twitter".lowercased():
            return UIKeyboardType.twitter
        case "Twitter".lowercased():
            return UIKeyboardType.webSearch
        default:
            return UIKeyboardType.default
        }
    }
    
    
    var underlineStyle:NSUnderlineStyle{
        switch self.lowercased() {
        case "None".lowercased() :
            return NSUnderlineStyle.styleNone
        case "StyleSingle".lowercased() :
            return NSUnderlineStyle.styleSingle
        case "StyleThick".lowercased() :
            return NSUnderlineStyle.styleThick
        case "StyleDouble".lowercased() :
            return NSUnderlineStyle.styleDouble
        case "PatternDot".lowercased() :
            return NSUnderlineStyle.patternDot
        case "PatternDash".lowercased() :
            return NSUnderlineStyle.patternDash
        case "PatternDashDot".lowercased() :
            return NSUnderlineStyle.patternDashDot
        case "PatternDashDotDot".lowercased() :
            return NSUnderlineStyle.patternDashDotDot
        case "ByWord".lowercased() :
            return NSUnderlineStyle.byWord
        default :
            return NSUnderlineStyle.styleSingle
        }
    }
    
    var controlEvent: UIControlEvents{
        switch self.lowercased() {
        case "TouchDown".lowercased() :
            return UIControlEvents.touchDown
        case "TouchDownRepeat".lowercased() :
            return UIControlEvents.touchDownRepeat
        case "TouchDragInside".lowercased() :
            return UIControlEvents.touchDragInside
        case "TouchDragOutside".lowercased() :
            return UIControlEvents.touchDragOutside
        case "TouchDragEnter".lowercased() :
            return UIControlEvents.touchDragEnter
        case "TouchDragExit".lowercased() :
            return UIControlEvents.touchDragExit
        case "TouchUpInside".lowercased() :
            return UIControlEvents.touchUpInside
        case "TouchUpOutside".lowercased() :
            return UIControlEvents.touchUpOutside
        case "ValueChanged".lowercased() :
            return UIControlEvents.valueChanged
        case "TouchCancel".lowercased() :
            return UIControlEvents.touchCancel
        case "EditingDidBegin".lowercased() :
            return UIControlEvents.editingDidBegin
        case "EditingChanged".lowercased() :
            return UIControlEvents.editingChanged
        case "EditingDidEnd".lowercased() :
            return UIControlEvents.editingDidEnd
        case "EditingDidEndOnExit".lowercased() :
            return UIControlEvents.editingDidEndOnExit
        case "AllTouchEvents".lowercased() :
            return UIControlEvents.allTouchEvents
        case "AllEditingEvents".lowercased() :
            return UIControlEvents.allEditingEvents
        case "ApplicationReserved".lowercased() :
            return UIControlEvents.applicationReserved
        case "SystemReserved".lowercased() :
            return UIControlEvents.systemReserved
        case "AllEvents".lowercased() :
            return UIControlEvents.allEvents
        default :
            return UIControlEvents.touchUpInside
        }
    }
    
}
