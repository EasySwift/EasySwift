//
//  Regex.swift
//  Cupertino
//
//  Created by William Kent on 2/19/15.
//  Copyright (c) 2015 William Kent. All rights reserved.
//

import Foundation

private func convertRange(_ range: NSRange, relativeToString string: String) -> Range<String.Index> {
    let start = string.characters.index(string.startIndex, offsetBy: range.location)
    let end = string.characters.index(string.startIndex, offsetBy: NSMaxRange(range))
    return (start ..< end)
}

public enum RegexFlags {
    case caseInsensitive
    case allowCommentsAndWhitespace
    case ignoreMetacharacters
    case dotMatchesLineSeparators
    case anchorsMatchLines
    case useUnicodeWordBoundaries
}

public struct Regex {
    public let pattern: String
    public var options: Set<RegexFlags>
    
    public init(_ pattern: String, options: Set<RegexFlags>) {
        self.pattern = pattern
        self.options = options
    }
    
    public init(_ pattern: String) {
        self.pattern = pattern
        self.options = []
    }
    
    fileprivate var matcherOptions: NSRegularExpression.Options {
        get {
            var opts: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive
            
            if options.contains(.caseInsensitive) {
                opts = NSRegularExpression.Options.caseInsensitive
            }
            if options.contains(.allowCommentsAndWhitespace) {
                opts = NSRegularExpression.Options.allowCommentsAndWhitespace
            }
            if options.contains(.ignoreMetacharacters) {
                opts = NSRegularExpression.Options.ignoreMetacharacters
            }
            if options.contains(.dotMatchesLineSeparators) {
                opts = NSRegularExpression.Options.dotMatchesLineSeparators
            }
            if options.contains(.anchorsMatchLines) {
                opts = NSRegularExpression.Options.anchorsMatchLines
            }
            if options.contains(.useUnicodeWordBoundaries) {
                opts = NSRegularExpression.Options.useUnicodeWordBoundaries
            }
            
            return opts
        }
    }
    
    fileprivate var matcher: NSRegularExpression? {
        get {
            return try? NSRegularExpression(pattern: self.pattern, options: self.matcherOptions)
        }
    }
    
    public func test(_ string: String) -> Bool? {
        return test(string, options: [])
    }
    
    public func test(_ string: String, options: NSRegularExpression.MatchingOptions) -> Bool? {
        // This function returns true if the regex matches, false if the regex does
        // not match, or nil if there is a syntax error in the regex itself.
        if let matcher = matcher {
            return matcher.numberOfMatches(in: string, options: options, range: NSMakeRange(0, string.characters.count)) != 0
        } else {
            return nil
        }
    }
    
    public func match(_ string: String) -> [RegexMatch]? {
        return match(string, options: [])
    }
    
    public func match(_ string: String, options: NSRegularExpression.MatchingOptions) -> [RegexMatch]? {
        if let matcher = matcher {
            let cocoaMatches = matcher.matches(in: string, options: options, range: NSMakeRange(0, string.characters.count))
            var retval = [RegexMatch]()
            
            for match: AnyObject in cocoaMatches {
                if let match = match as? NSTextCheckingResult {
                    retval.append(RegexMatch(cocoaMatch: match, inString: string))
                }
            }
            
            return retval
        } else {
            return nil
        }
    }
    
    public func match(_ string: String, options: NSRegularExpression.MatchingOptions, startPosition: Int) -> [RegexMatch]? {
        if let matcher = matcher {
            let cocoaMatches = matcher.matches(in: string, options: options, range: NSMakeRange(startPosition, string.characters.count - startPosition))
            var retval = [RegexMatch]()
            
            for match: AnyObject in cocoaMatches {
                if let match = match as? NSTextCheckingResult {
                    retval.append(RegexMatch(cocoaMatch: match, inString: string))
                }
            }
            
            return retval
        } else {
            return nil
        }
    }
    
    public func replace(_ string: String, withTemplate template: String) -> String? {
        return replace(string, options: [], withTemplate: template)
    }
    
    public func replace(_ string: String, options: NSRegularExpression.MatchingOptions, withTemplate template: String) -> String? {
        if let matcher = matcher {
            let workString = NSMutableString(string: string)
            matcher.replaceMatches(in: workString, options: options, range: NSMakeRange(0, workString.length), withTemplate: template)
            let retval = workString as NSString
            return String(retval)
        }
        
        return nil
    }
    
    public func replace(_ string: String, withBlock block: (RegexMatch) -> String) -> String? {
        return replace(string, options: [], withBlock: block)
    }
    
    public func replace(_ string: String, options: NSRegularExpression.MatchingOptions, withBlock block: (RegexMatch) -> String) -> String? {
        if let matches = match(string, options: options) {
            var replacements: [(NSRange, String)] = []
            
            for match in matches {
                let replacedSubstring = block(match)
                replacements.append((match.range, replacedSubstring))
            }
            
            // Sort the replacements in order of location, then reverse it.
            // By applying the replacements in right-to-left order, I avoid having
            // to recalculate all the indices when a replacement changes the length
            // of the replaced substring.
            replacements.sort(by: {
                (lhs, rhs) -> Bool in
                let (leftRange, _) = lhs
                let (rightRange, _) = rhs
                
                return leftRange.location < rightRange.location
            })
            replacements = Array(replacements.reversed())
            
            var retval = string
            for pair in replacements {
                let (range, substring) = pair
                retval.replaceSubrange(convertRange(range, relativeToString: retval), with: substring)
            }
            
            return retval
        } else {
            return nil
        }
    }
}

extension Regex: ExpressibleByStringLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = UnicodeScalar
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.pattern = "\(value)"
        self.options = []
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.pattern = value
        self.options = []
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.pattern = value
        self.options = []
    }
}
