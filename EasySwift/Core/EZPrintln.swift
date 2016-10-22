//
//  EZPrintln.swift
//  EasySwift
//
//  Created by YXJ on 16/7/3.
//  Copyright (c) 2016年 YXJ. All rights reserved.
//

import Foundation

public var DEBUG = true

public func EZPrintln<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    if DEBUG {
        let file: String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        print("\(file)\(methodName)[\(lineNumber)]:\(message)")
    }
}
