//
//  Match.swift
//  Cupertino
//
//  Created by William Kent on 2/19/15.
//  Copyright (c) 2015 William Kent. All rights reserved.
//

import Foundation

private func safeSubstring(_ whole: String, range: NSRange) -> String? {
    if range.location != NSNotFound && range.length != 0 {
        return (whole as NSString).substring(with: range)
    } else {
        return nil
    }
}

public struct RegexMatch {
    fileprivate let sourceString: String
    fileprivate let cocoaMatch: NSTextCheckingResult
    
    internal init(cocoaMatch: NSTextCheckingResult, inString source: String) {
        self.sourceString = source
        self.cocoaMatch = cocoaMatch
    }
    
    public var range: NSRange {
        get {
            return cocoaMatch.range
        }
    }
    
    public var entireMatch: String? {
        get {
            return safeSubstring(sourceString, range: cocoaMatch.range)
        }
    }
    
    public var subgroupCount: Int {
        get {
            return cocoaMatch.numberOfRanges - 1
        }
    }
    
    public func subgroupRangeAtIndex(_ index: Int) -> NSRange? {
        return cocoaMatch.rangeAt(index + 1)
    }
    
    public func subgroupMatchAtIndex(_ index: Int) -> String? {
        let range = cocoaMatch.rangeAt(index + 1)
        return safeSubstring(sourceString, range: range)
    }
}
