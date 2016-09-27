//
//  ENSObject.swift
//  Pods
//
//  Created by zhuchao on 15/7/21.
//
//

import Foundation
import JavaScriptCore

@objc public protocol ENSObject:JSExport{
    func val(_ keyPath:String) -> AnyObject?
    func attr(_ keyPath:String,_ value:AnyObject?)
    func attrs(_ dict:[AnyHashable: Any]!)
    func call(_ selector:String)
    func call(_ selector:String,withObject object:AnyObject?)
}

public extension NSObject{
    
    public func call(_ selector:String){
        Thread.detachNewThreadSelector(Selector(selector), toTarget:self, with: nil)
    }
    
    public func call(_ selector:String,withObject object:AnyObject?){
        Thread.detachNewThreadSelector(Selector(selector), toTarget:self, with: object)
    }
    
    public func attr(_ key:String,_ value:AnyObject?) {
        SwiftTryCatch.`try`({
            if let str = value as? String {
                self.setValue(str.anyValue(key.toKeyPath), forKeyPath: key.toKeyPath)
            }else{
                self.setValue(value, forKeyPath: key.toKeyPath)
            }
        }, catch: { (error) in
            print("JS Error:\(error?.description)")
        }, finally: nil)
    }
    
    public func attrs(_ dict:[String : AnyObject]!){
        var dict = dict
        SwiftTryCatch.`try`({
            for (key, value) in dict! {
                if let str = value as? String {
                    dict?[key.toKeyPath] = str.anyValue(key.toKeyPath)
                }
            }
            self.setValuesForKeys(dict!)
        }, catch: { (error) in
            print("JS Error:\(error?.description)")
        }, finally: nil)
    }
    
    public func val(_ key:String) -> AnyObject? {
        var result:AnyObject?
        SwiftTryCatch.`try`({
            result = self.value(forKeyPath: key.toKeyPath) as AnyObject?
            }, catch: { (error) in
                print("JS Error:\(error?.description)")
            }, finally: nil)
        return result
    }
}

@objc public protocol EZActionJSExport:JSExport{
    static func SEND_IQ_CACHE (_ req:EZRequest)
    static func SEND_CACHE (_ req:EZRequest)
    static func SEND (_ req:EZRequest)
    static func Upload (_ req:EZRequest)
    static func Download (_ req:EZRequest)
}
