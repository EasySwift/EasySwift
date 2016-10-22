//
//  EZPrintln.swift
//  EasySwift
//
//  Created by YXJ on 16/7/3.
//  Copyright (c) 2016年 YXJ. All rights reserved.
//

import Foundation

public var DEBUG = true

public func EZPrintln<T>(_ message: T, fileName: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__) {
    if DEBUG {
        let file: String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(file)\(methodName)[\(lineNumber)]:\(message)")
    }
}
