//
//  EUI.swift
//  medical
//
//  Created by zhuchao on 15/5/5.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


open class EUI: NSObject {
    open class func encode(_ fileName:String,suffix:String = "xml",toPath:String){
        let path = Bundle.main.path(forResource: fileName, ofType: suffix)!
        if  FileManager.default.fileExists(atPath: path) == false{
            return
        }
        if let str = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
            if let encrypt = DesEncrypt.encrypt(withText: str, key: CRTPTO_KEY) {
                var error:NSError?
                do {
                    try encrypt.write(toFile: toPath, atomically: true, encoding: String.Encoding.utf8)
                    EZPrintln("success")
                } catch let error1 as NSError {
                    error = error1
                    EZPrintln(error)
                }
            }
        }
    }
    
    open class func setLiveLoad(_ controller:EUScene,suffix:String){
        if IsSimulator && suffix == "xml"{
            let paths = self.loadLiveFile(controller,suffix:suffix)
            if paths?.count > 0 {
                for path in paths! {
                    watchForChangesToFilePath(path) {
                        self.loadLiveFile(controller,suffix:suffix)
                        controller.eu_viewWillLoad()
                        controller.loadEZLayout()
                    }
                }
            }
        }else{
            self.loadHtml(controller, suffix: suffix)
        }
        controller.eu_viewWillLoad()
    }
    
    fileprivate class func loadLiveFile(_ controller:EUScene,suffix:String) -> [String]?{
        let fileName = controller.nameOfClass
        
        let path = Bundle(path: LIVE_LOAD_PATH)!.path(forResource: fileName, ofType: suffix)!
        if  FileManager.default.fileExists(atPath: path) == false{
            return nil
        }
        var paths = Array<String>()
        paths.append(path)
        
        do{
            if let html = try? String(contentsOfFile: path, encoding: String.Encoding.utf8){
                var finalHtml = html
                if let newHtml = Regex("@import\\(([^\\)]*)\\)").replace(finalHtml,withBlock: { (regx) -> String in
                    let subFile = regx.subgroupMatchAtIndex(0)?.trim
                    let subPath = Bundle(path: LIVE_LOAD_PATH)!.path(forResource: subFile, ofType: suffix)!
                    if FileManager.default.fileExists(atPath: subPath) {
                        paths.append(subPath)
                        return try! String(contentsOfFile:subPath, encoding: String.Encoding.utf8)
                    }else{
                        return ""
                    }
                }) {
                    finalHtml = newHtml
                }
                
                if let regMatchs = Regex("<style>([\\s\\S]*?)</style>").match(finalHtml) {
                    for regx in regMatchs {
                        if let styleString = regx.subgroupMatchAtIndex(0)?.trim,
                            let regxsubs = Regex("\\.([\\w]*)[\\s]*\\{[\\s]?([^}]*)[\\s]?\\}").match(styleString){
                                for regxsub in regxsubs {
                                    let className = regxsub.subgroupMatchAtIndex(0)!.trim
                                    let values = regxsub.subgroupMatchAtIndex(1)!.trim
                                    if let aHtml = Regex("@"+className).replace(finalHtml, withTemplate: values) {
                                        finalHtml = aHtml
                                    }
                                }
                        }
                    }
                }
                
                if let regMatchs = Regex("<script\\b[^>]*>([\\s\\S]*?)</script>").match(finalHtml) {
                    var scriptStrings = "";
                    for regx in regMatchs {
                        if let scriptString = regx.subgroupMatchAtIndex(0)?.trim{
                            scriptStrings += scriptString
                        }
                    }
                    controller.scriptString = scriptStrings
                }
                
                if let cleanHtml = Regex("@[\\w]*").replace(finalHtml, withTemplate: "") {
                    finalHtml = cleanHtml
                }
              
                SwiftTryCatch.`try`({
                    let body = EUIParse.ParseHtml(finalHtml)
                    var views = [UIView]()
                    for aview in body {
                        views.append(aview.getView())
                    }
                    controller.eu_subViews = views
                    }, catch: { (error) in
                        print(controller.nameOfClass + "Error:\(error?.description)")
                    }, finally: nil)
             
            }else{
                throw NSError(domain: "EasyIOS", code: -1, userInfo: ["err":"can not open "+path.URLString])
            }
        }catch let error as NSError{
            print("error is \(error)")
        }
        
        return paths
    }
    
    fileprivate class func loadHtml (_ controller:EUScene,suffix:String){
        let fileName = controller.nameOfClass
        
        let path = Bundle(path: BUNDLE_PATH)!.path(forResource: fileName, ofType: suffix)!
        if  FileManager.default.fileExists(atPath: path) == false{
            return
        }
        if let html = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
            var finalHtml = html
            if suffix == "crypto" && CRTPTO_KEY != "" {
                if let aHtml = DesEncrypt.decrypt(withText: finalHtml, key: CRTPTO_KEY) {
                    finalHtml = aHtml
                }
            }
            if let newHtml = Regex("@import\\(([^\\)]*)\\)").replace(finalHtml,withBlock: { (regx) -> String in
                let subFile = regx.subgroupMatchAtIndex(0)?.trim
                let subPath = Bundle(path: BUNDLE_PATH)!.path(forResource: subFile, ofType: suffix)!
                
                if FileManager.default.fileExists(atPath: subPath) {
                    return try! String(contentsOfFile:subPath, encoding: String.Encoding.utf8)
                }else{
                    return ""
                }
            }) {
                finalHtml = newHtml
            }
            
            
            if let regMatchs = Regex("<style>([\\s\\S]*?)</style>").match(finalHtml) {
                for regx in regMatchs {
                    if let styleString = regx.subgroupMatchAtIndex(0)?.trim,
                        let regxsubs = Regex("\\.([\\w]*)[\\s]*\\{[\\s]?([^}]*)[\\s]?\\}").match(styleString){
                            for regxsub in regxsubs {
                                let className = regxsub.subgroupMatchAtIndex(0)!.trim
                                let values = regxsub.subgroupMatchAtIndex(1)!.trim
                                if let aHtml = Regex("@"+className).replace(finalHtml, withTemplate: values) {
                                    finalHtml = aHtml
                                }
                            }
                    }
                }
            }
            
            if let regMatchs = Regex("<script\\b[^>]*>([\\s\\S]*?)</script>").match(finalHtml) {
                var scriptStrings = "";
                for regx in regMatchs {
                    if let scriptString = regx.subgroupMatchAtIndex(0)?.trim{
                        scriptStrings += scriptString
                    }
                }
                controller.scriptString = scriptStrings
            }
        
            
            if let cleanHtml = Regex("@[\\w]*").replace(finalHtml, withTemplate: "") {
                finalHtml = cleanHtml
            }
            
            SwiftTryCatch.`try`({
                    let body = EUIParse.ParseHtml(finalHtml)
                    var views = [UIView]()
                    for aview in body {
                        views.append(aview.getView())
                    }
                    controller.eu_subViews = views
                }, catch: { (error) in
                    print(controller.nameOfClass + "Error:\(error?.description)")
                }, finally: nil)
        }
    }
    
    
}
