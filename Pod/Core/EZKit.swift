//
//  CEMKit.swift
//  CEMKit-Swift
//
//  Created by Cem Olcay on 05/11/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import UIKit



// MARK: - UIBarButtonItem

public func barButtonItem (_ imageName: String,
    action: @escaping (AnyObject)->()) -> UIBarButtonItem {
        let button = BlockButton (frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(named: imageName), for: UIControlState())
        button.actionBlock = action
        
        return UIBarButtonItem (customView: button)
}

public func barButtonItem (_ title: String,
    color: UIColor,
    action: @escaping (AnyObject)->()) -> UIBarButtonItem {
        let button = BlockButton (frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(color, for: UIControlState())
        button.actionBlock = action
        button.sizeToFit()
        
        return UIBarButtonItem (customView: button)
}



// MARK: - CGSize

public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width + right.width, height: left.height + right.height)
}

public func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width - right.width, height: left.width - right.width)
}



// MARK: - CGPoint

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x - right.x, y: left.y - right.y)
}


public enum AnchorPosition: CGPoint {
    case topLeft        = "{0, 0}"
    case topCenter      = "{0.5, 0}"
    case topRight       = "{1, 0}"
    
    case midLeft        = "{0, 0.5}"
    case midCenter      = "{0.5, 0.5}"
    case midRight       = "{1, 0.5}"
    
    case bottomLeft     = "{0, 1}"
    case bottomCenter   = "{0.5, 1}"
    case bottomRight    = "{1, 1}"
}

extension CGPoint: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
}



// MARK: - CGFloat

public func degreesToRadians (_ angle: CGFloat) -> CGFloat {
    return (CGFloat (M_PI) * angle) / 180.0
}


public func normalizeValue (_ value: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
    return (max - min) / value
}


public func convertNormalizedValue (_ value: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
    return ((max - min) * value) + min
}



// MARK: - Block Classes


// MARK: - BlockButton

open class BlockButton: UIButton {
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var actionBlock: ((_ sender: BlockButton) -> ())? {
        didSet {
            self.addTarget(self, action: #selector(BlockButton.action(_:)), for: UIControlEvents.touchUpInside)
        }
    }
    
    func action (_ sender: BlockButton) {
        actionBlock! (sender)
    }
}



// MARK: - BlockWebView

open class BlockWebView: UIWebView, UIWebViewDelegate {
    
    var didStartLoad: ((URLRequest?) -> ())?
    var didFinishLoad: ((URLRequest?) -> ())?
    var didFailLoad: ((URLRequest?, NSError?) -> ())?
    
    var shouldStartLoadingRequest: ((URLRequest) -> (Bool))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc open func webViewDidStartLoad(_ webView: UIWebView) {
        didStartLoad? (webView.request)
    }
    
    @objc open func webViewDidFinishLoad(_ webView: UIWebView) {
        didFinishLoad? (webView.request)
    }
    @objc  open func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        didFailLoad? (webView.request, error as NSError?)
    }
    
    @objc open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let should = shouldStartLoadingRequest {
            return should (request)
        } else {
            return true
        }
    }
    
}


public func nsValueForAny(_ anyValue:Any) -> NSObject? {
    switch(anyValue) {
    case let intValue as Int:
        return NSNumber(value: CInt(intValue) as Int32)
    case let doubleValue as Double:
        return NSNumber(value: CDouble(doubleValue) as Double)
    case let stringValue as String:
        return stringValue as NSString
    case let boolValue as Bool:
        return NSNumber(value: boolValue as Bool)
    default:
        return nil
    }
}

extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }

    
    public func listProperties() -> Dictionary<String,AnyObject>{

        var modelDictionary = Dictionary<String,AnyObject>()
        Mirror(reflecting: self).children.forEach { (element) -> () in
            if  element.label != "super" {
                if let nsValue = nsValueForAny(element.value) {
                    modelDictionary.updateValue(nsValue, forKey: element.label!)
                }
            }
        }
        return modelDictionary
    }
    
}


public func isEmpty<C : NSObject>(_ x: C) -> Bool {
    if x.isKind(of: NSNull.self) {
        return true
    }else if x.responds(to: #selector(_NSStringCoreType.length)) && Data().self.count == 0 {
        return true
    }else if x.responds(to: #selector(getter: CIVector.count)) && NSArray().self.count == 0 {
        return true
    }
    return false
}




