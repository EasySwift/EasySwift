//
//  EUScene.swift
//  medical
//
//  Created by zhuchao on 15/5/6.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import JavaScriptCore

public var LIVE_LOAD_PATH = Bundle.main.path(forResource: "xml", ofType: "bundle")!
public var BUNDLE_PATH = Bundle.main.path(forResource: "xml", ofType: "bundle")!

public var CRTPTO_KEY = ""


@objc protocol EUSceneExport:JSExport {
    func getElementById(_ id:String) -> UIView
}

open class EUScene: EZScene,EUSceneExport{
    
    
    open func getElementById(_ id:String) -> UIView {
        return UIView.formTag(id)
    }
    
    open var SUFFIX = "xml"
    open var eu_subViews:[UIView]?
    open var scriptString:String?
    
    open var context = EZJSContext()
    
    open func define(_ funcName:String,actionBlock:@convention(block) ()->Void){
        context.define(funcName, actionBlock: actionBlock)
    }
    
    open func eval(_ script: String?) -> JSValue?{
        if let str =  script {
            var result:JSValue?
            SwiftTryCatch.`try`({
                result = self.context.evaluateScript(str)
                }, catch: { (error) in
                    print("JS Error:\(error?.description)")
                }, finally: nil)
            return result
        }else{
            return nil
        }
    }
    
    override open func loadView() {
        super.loadView()
        EUI.setLiveLoad(self,suffix: SUFFIX)
        
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.extendedLayoutIncludesOpaqueBars = true;
        self.edgesForExtendedLayout = UIRectEdge.all;
        self.view.backgroundColor = UIColor.white
        self.loadEZLayout()
    }
    
    open func eu_viewWillLoad(){
    
    }
    
    open func eu_viewDidLoad(){

    }

    open func eu_tableViewDidLoad(_ tableView:UITableView?){
        
    }
    
    open func eu_collectionViewDidLoad(_ collectionView:UICollectionView?){
        
    }

    
}
