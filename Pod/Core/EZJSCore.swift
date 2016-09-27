import UIKit
import JavaScriptCore


@objc protocol ConsoleExport:JSExport {
    static func log(_ object:AnyObject?)
}

@objc open class Console:NSObject,ConsoleExport {
    static open func log(_ object:AnyObject?){
        if let obj: AnyObject = object{
            print(obj)
        }
    }
}


@objc protocol JSURLManagerExport:JSExport {
    static func present(_ url:String,_ animated:Bool)
    static func push(_ url:String,_ animated:Bool)
    static func dismiss(_ animated:Bool)
}

open class JSURLManager:NSObject,JSURLManagerExport {
    static open func present(_ url:String,_ animated:Bool){
        let viewController = UIViewController.initFrom(url, fromConfig: URLManager.shareInstance().config)
        let nav = EZNavigationController(rootViewController: viewController!)
        URLNavigation.present(nav, animated: animated)
    }
    
    static open func push(_ url:String,_ animated:Bool){
        URLManager.pushURLString(url, animated: animated)
    }
    
    static open func dismiss(_ animated:Bool){
        URLNavigation.dismissCurrent(animated: animated)
    }
}

open class EZJSContext:JSContext{
    
    override init(){
        super.init()
        
        self.setObject(Console.self, forKeyedSubscript: "console" as (NSCopying & NSObjectProtocol)!)
        self.setObject(JSURLManager.self, forKeyedSubscript: "um" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(EZAction.self, EZActionJSExport.self)
        self.setObject(EZAction.self, forKeyedSubscript: "EZAction" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UIColor.self, EUIColor.self)
        self.setObject(UIColor.self, forKeyedSubscript: "UIColor" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UIImage.self, EUIImage.self)
        self.setObject(UIImage.self, forKeyedSubscript: "UIImage" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UIView.self, EUIView.self)
        self.setObject(UIView.self, forKeyedSubscript: "UIView" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UIImageView.self, EUIImageView.self)
        self.setObject(UIImageView.self, forKeyedSubscript: "UIImageView" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UITextField.self, EUITextField.self)
        self.setObject(UITextField.self, forKeyedSubscript: "UITextField" as (NSCopying & NSObjectProtocol)!)

        class_addProtocol(UIButton.self, EUIButton.self)
        self.setObject(UIButton.self, forKeyedSubscript: "UIButton" as (NSCopying & NSObjectProtocol)!)

        class_addProtocol(UILabel.self, EUILabel.self)
        self.setObject(UILabel.self, forKeyedSubscript: "UILabel" as (NSCopying & NSObjectProtocol)!)

        class_addProtocol(UIScrollView.self, EUIScrollView.self)
        self.setObject(UIScrollView.self, forKeyedSubscript: "UIScrollView" as (NSCopying & NSObjectProtocol)!)

        class_addProtocol(UITableView.self, EUITableView.self)
        self.setObject(UITableView.self, forKeyedSubscript: "UITableView" as (NSCopying & NSObjectProtocol)!)
        
        class_addProtocol(UICollectionView.self, EUICollectionView.self)
        self.setObject(UICollectionView.self, forKeyedSubscript: "UICollectionView" as (NSCopying & NSObjectProtocol)!)
        
        
        self.exceptionHandler = { context, exception in
            print("JS Error: \(exception)")
        }
    }
    
    override init(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine:virtualMachine)
    }

    
    open func define(_ funcName:String,actionBlock:@convention(block) ()->Void){
        self.setObject(unsafeBitCast(actionBlock, to: AnyObject.self), forKeyedSubscript:funcName as (NSCopying & NSObjectProtocol)!)
    }
}
