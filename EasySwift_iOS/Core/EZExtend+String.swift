//
//  EZExtend+String.swift
//  medical
//
//  Created by zhuchao on 15/4/28.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation
import UIKit
// MARK: - String

public func trimToArray(_ str: String) -> Array<String> {
    return str.trim.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter() {
        return !$0.characters.isEmpty
    }
}

public func trimToArrayBy(_ str: String, by: String) -> Array<String> {
    return str.trim.components(separatedBy: by).filter() {
        return !$0.characters.isEmpty
    }
}

extension String {
    public subscript(i: Int) -> String {
        return String(Array(self.characters)[i])
    }

    public var urlencode: String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.letters)
    }

    public var urldecode: String? {
        return self.removingPercentEncoding
    }

    // MARK: 取消首位空格和换行
    public var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public var trimArray: Array<String> {
        return trimToArray(self)
    }

    public func trimArrayBy(_ str: String) -> Array<String> {
        return trimToArrayBy(self, by: str)
    }

    public var toKeyPath: String {
        let keyArray = self.trim.components(separatedBy: "-")
        var str = ""
        var index = 0
        for akey in keyArray {
            if index == 0 {
                str += akey
            } else {
                str += akey.capitalized
            }
            index += 1
        }
        if let reg = Regex("_").replace(str, withTemplate: ".") {
            str = reg
        }
        return str
    }

    public var floatValue: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }

    public var integerValue: Int {
        return (self as NSString).integerValue
    }

    public var boolValue: Bool {
        return (self as NSString).boolValue
    }

    public func anyValue(_ key: String) -> AnyObject {
        if key == "font" {
            if let font = UIFont.Font(self.trim) {
                return font
            }
        }
        return self.anyValue
    }

    public var anyValue: AnyObject {
        let str = self.trim

        if str.hasSuffix(".cg") {
            if let color = UIColor(css: Regex(".cg").replace(str, withTemplate: "")) {
                return color.cgColor
            }
        }

        if ["YES", "NO", "TRUE", "FALSE"].contains(str.uppercased()) {
            return str.boolValue as AnyObject
        } else if let color = UIColor(css: str) {
            return color
        } else if let image = UIImage(named: str) {
            return image
        } else if str.floatValue != 0.0 {
            return str.floatValue as AnyObject
        } else {
            return str as AnyObject
        }
    }

    public var MD5: String {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false) as NSData?
        return data!.md5String
    }

    public func toData() -> Data? {
        return (self.data(using: String.Encoding.utf8) as NSData?)?.replacingOccurrences(of: "\\n".data(using: String.Encoding.utf8), with: "\n".data(using: String.Encoding.utf8))
    }

    public var chineseFirstLetter: String {
        return HTFirstLetter.firstLetter(self)
    }

    public var chineseFirstLetters: String {
        return HTFirstLetter.firstLetters(self)
    }
}
