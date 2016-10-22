//
//  String+YXJ.swift
//  TSLSmartHome
//
//  Created by yuanxiaojun on 16/3/25.
//  Copyright © 2016年 特斯联. All rights reserved.
//

import UIKit

//#define IS_SCREEN_35_INCH ([UIScreen mainScreen].bounds.size.height == 480) ? YES : NO
//#define IS_SCREEN_4_INCH ([UIScreen mainScreen].bounds.size.height == 568) ? YES : NO
//#define IS_SCREEN_47_INCH ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO
//#define IS_SCREEN_55_INCH ([UIScreen mainScreen].bounds.size.height == 736) ? YES : NO

extension String {

    // MARK:获取字符串的长度
    public var length: Int {
        let temp = (self as NSString).length
        return temp
    }

    // MARK:字符串的截取
    /**
     swift3的方式截取

     - parameter start: 开始位置
     - parameter end:   结束位置

     - returns: 截取后的string字符串
     */
    public func substringWithRange(_ start: Int, end: Int) -> String {
        let rage: Range<String.Index> = self.characters.index(self.startIndex, offsetBy: start) ..< self.characters.index(self.endIndex, offsetBy: end)
//        let rage = start..<end
        let str = self.substring(with: rage)
        return str
    }

    /**
     oc的方式截取字符串

     - parameter start:  开始位置
     - parameter length: 截取的长度

     - returns: 截取后的string字符串
     */
    public func substringWithRange(_ start: Int, length: Int) -> String {
        let asNSString = self as NSString
        let temp = asNSString.substring(with: NSRange(location: start, length: length))
        return temp
    }

    // MARK: 去除HTML标签
    public func filterHTML(_ html: String) -> String {
        var temp = html
        let scanner: Scanner = Scanner.init(string: temp)
        var text: NSString?
        while scanner.isAtEnd == false {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo("<", into: &text)
            temp = temp.replacingOccurrences(of: "\(text)>", with: "")
        }
        return temp
    }

    // MARK:
    public func empty() -> Bool {

        return self.isEmpty
    }

    // MARK:
    public func notEmpty() -> Bool {
        return !self.isEmpty
    }

    // MARK:
    // public func isTelephone2() -> Bool {
    //
    // let pred_Unicom:NSPredicate = NSPredicate.init(format: "SELF MATCHES ^(1)[0-9]{10}", argumentArray: nil)
    // let isMatch_CMCC:Bool = pred_Unicom.evaluateWithObject(self)
    // return isMatch_CMCC
    // }

    // MARK:
    public func validateIdentityCard() -> Bool {
        var flag: Bool
        if self.isEmpty {
            flag = false
            return flag
        }

        let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate: NSPredicate = NSPredicate.init(format: "SELF MATCHES \(regex2)", argumentArray: nil)

        return identityCardPredicate.evaluate(with: self)
    }
    // MARK: 拼音转换
    public func pinYin() -> String {
        let str: String = self

        CFStringTransform(str as! CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        CFStringTransform(str as! CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        return str
    }
    // MARK: 根据宽度计算高度
    public func sizeWithFontByWith(_ font: UIFont, byWith: CGFloat) -> CGSize {
        let str: NSString = self as NSString
        let attribute: [String: AnyObject] = [NSFontAttributeName: font]
        let rct: CGRect = str.boundingRect(with: CGSize(width: byWith, height: 999999.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil)
        return rct.size
    }
    // MARK: 根据高度计算宽度
    public func sizeWithFontByHeight(_ font: UIFont, byHeight: CGFloat) -> CGSize {
        let str: NSString = self as NSString
        let attribute: [String: AnyObject] = [NSFontAttributeName: font]
        let rct: CGRect = str.boundingRect(with: CGSize(width: 999999.0, height: byHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil)
        return rct.size
    }

    // MARK: 返回显示字串所需要的尺寸
    public func calculateSize(_ size: CGSize, font: UIFont) -> CGSize {
        var expectedLabelSize: CGSize = CGSize.zero
        let str: NSString = self as NSString
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping

        let attributes: [String: AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle];
        expectedLabelSize = str.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).size

        return CGSize(width: ceil(expectedLabelSize.width), height: ceil(expectedLabelSize.height))
    }

    // MARK:字符串转int
    /**
     字符串转int  string to  int

     - parameter str: string

     - returns: int
     */
    public func toInt() -> Int {
        return Int((self as NSString).intValue)
    }

    // MARK:字符串转double
    /**
     字符串转double

     - returns: double
     */
    public func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }

    /**
     String 转 NSString

     - parameter str: string

     - returns: NSString
     */
    public func stringFormat(_ str: String) -> NSString {
        return NSString(cString: str.cString(using: String.Encoding.utf8)!,
            encoding: String.Encoding.utf8.rawValue)!
    }
}
