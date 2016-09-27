//
//  Scene.swift
//  medical
//
//  Created by zhuchao on 15/4/22.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import SnapKit

public enum NAV: Int {
    case left
    case right
}

public enum EXTEND: Int {
    case none
    case top
    case bottom
    case top_BOTTOM
}

public enum INSET: Int {
    case none
    case top
    case bottom
    case top_BOTTOM
}

open class EZScene: UIViewController {

    // parentScene 保留设计，必要的时候保存parentScene
    open weak var parentScene: EZScene?

    open func addSubView(_ view: UIView, extend: EXTEND) {
        self.view.addSubview(view)
        self.view.sendSubview(toBack: view)

        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = UIRectEdge.all
        view.snp_makeConstraints { (make) -> Void in
            // TODO
//            make.edges.equalTo(view.superview!).inset(
//                EdgeInsetsMake((extend == EXTEND.TOP||extend == EXTEND.TOP_BOTTOM) ? 64:0, left:0,bottom:(extend == EXTEND.BOTTOM||extend == EXTEND.TOP_BOTTOM) ? 49:0, right: 0)
//            )
        }
    }

    open func addScrollView(_ view: UIScrollView, extend: EXTEND, inset: INSET) {
        self.addSubView(view, extend: extend)
//        view.contentInset = UIEdgeInsetsMake((inset == INSET.TOP || inset == INSET.TOP_BOTTOM) ? 64:0, 0,
//            (inset == INSET.BOTTOM || inset == INSET.TOP_BOTTOM) ? 49:0, 0)
    }

}
