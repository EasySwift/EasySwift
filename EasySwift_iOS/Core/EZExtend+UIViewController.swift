//
//  EZExtend+UIViewController.swift
//  medical
//
//  Created by zhuchao on 15/4/28.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit

let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

extension UIViewController {

    public var top: CGFloat {
        get {
            if let nav = self.navigationController {
                if nav.isNavigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }

    public var bottom: CGFloat {
        get {
            if let tab = tabBarController {
                if tab.tabBar.isHidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }

    public var navigationBarHeight: CGFloat {
        get {
            if let nav = self.navigationController {
                return nav.navigationBar.h
            }

            return 0
        }
    }

    public var navigationBarColor: UIColor? {
        get {
            return navigationController?.navigationBar.tintColor
        } set (value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }

    public var navigationBar: UINavigationBar? {
        get {
            return navigationController?.navigationBar
        }
    }

    public var applicationFrame: CGRect {
        get {
            return CGRect (x: view.x, y: top, width: view.w, height: bottom - top)
        }
    }

    // 导航条左右按钮设置 NAV是一个枚举值：.LEFT,.RIGHT
    public func showBarButton(_ position: NAV, title: String, fontColor: UIColor) {
        self.showBarButton(position, button: UIButton(navTitle: title, color: fontColor))
    }

    public func showBarButton(_ position: NAV, imageName: String) -> Void {
        self.showBarButton(position, button: UIButton(navImage: UIImage(named: imageName)!))
    }

    public func showBarButton(_ position: NAV, button: UIButton?) {
        if position == .left {
            button?.addTarget(self, action: #selector(UIViewController.leftButtonTouch), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button!)
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        } else if position == .right {
            button?.addTarget(self, action: #selector(UIViewController.rightButtonTouch), for: UIControlEvents.touchUpInside)
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button!)
        }
    }

    public func leftButtonTouch() {
        self.navigationController?.popViewController(animated: true)
    }

    public func rightButtonTouch() {

    }

    public func setTitleView(_ titleView: UIView) {
        self.navigationItem.titleView = titleView
    }

    public class func ClassFromString(_ vcName: String) -> AnyClass {
        return NSClassFromString(ns + "." + vcName)!
        // return NSClassFromString(vcName)!
    }

    public func pushWithSelfStoryBoard_Swift(_ VCName: String) {
        pushWithOtherStoryBoard_Swift(VCName, storyBoardName: "")
    }

    public func pushWithOtherStoryBoard_Swift(_ VCName: String, storyBoardName: String) {
        let viewControllers = self.navigationController!.viewControllers
        var vc: UIViewController?

        for controllers in viewControllers {
            if controllers.isKind(of: UIViewController.ClassFromString(VCName)) {
                vc = controllers
            }
        }

        if (vc != nil) {
            self.navigationController?.popToViewController(vc!, animated: true)
        } else {
            var story: UIStoryboard?
            if (storyBoardName != "") {
                story = UIStoryboard(name: storyBoardName, bundle: nil)
            } else {
                story = self.storyboard
            }
            let controller: UIViewController = (story?.instantiateViewController(withIdentifier: VCName))!
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    public func getVCFormSelfStoryBoard_Swift(_ VCName: String) -> UIViewController {
        return getVCFormOtherStoryBoard_Swift(VCName, storyBoardName: "")
    }
    public func getVCFormOtherStoryBoard_Swift(_ VCName: String, storyBoardName: String) -> UIViewController {
        let viewControllers: Array = self.navigationController!.viewControllers
        var tempVC: UIViewController?
        for controllers in viewControllers {
            if controllers.isKind(of: UIViewController.ClassFromString(VCName)) {
                tempVC = controllers
            }
        }
        if (tempVC != nil) {
            return tempVC!
        } else {
            var story: UIStoryboard?
            if (storyBoardName != "") {
                story = UIStoryboard(name: storyBoardName, bundle: nil)
            } else {
                story = self.storyboard
            }
            let controller: UIViewController = (story?.instantiateViewController(withIdentifier: VCName))!
            return controller
        }
    }
    public func pushVC_Swift(_ vc: UIViewController) {
        let viewControllers: Array = self.navigationController!.viewControllers
        var tempVC: UIViewController?
        for controllers in viewControllers {
            if (controllers == vc) {
                tempVC = controllers
            }
        }
        if (tempVC != nil) {
            self.navigationController?.popToViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    /**
     //     获取今天时间戳,默认时间戳格式为"yyyy-MM-dd"
     //     - returns: 今天0点开始的时间戳到24点结束的时间戳
     //     */
    // public func todayTimesStamp(format: String = "yyyy-MM-dd") -> (startTS: Int, endTS: Int) {
    // let todayDate = NSDate()
    // let todayStr = todayDate.formatTo(format)
    //
    // let todaySimpleDate = NSDate().dateFromString(todayStr)
    //
    // return (Int(todaySimpleDate.timeIntervalSince1970), Int(todaySimpleDate.dateByAddingDays(1).timeIntervalSince1970))
    // }
    //
    // /**
    // 获取明天时间戳,默认时间戳格式为"yyyy-MM-dd"
    // - returns: 明天0点开始的时间戳到24点结束的时间戳
    // */
    // public func tomorrowTimesStamp(format: String = "yyyy-MM-dd") -> (startTS: Int, endTS: Int) {
    // let todayDate = NSDate()
    // let todayStr = todayDate.formatTo(format)
    //
    // let todaySimpleDate = NSDate().dateFromString(todayStr)
    //
    // return (Int(todaySimpleDate.dateByAddingDays(1).timeIntervalSince1970), Int(todaySimpleDate.dateByAddingDays(2).timeIntervalSince1970))
    // }
    //
    // /**
    // 获取周末时间戳,默认时间戳格式为"yyyy-MM-dd"
    // - returns: 本周周六0点开始的时间戳，周日到24点结束的时间戳
    // */
    // public func currentWeeksTimesStamp(format: String = "yyyy-MM-dd") -> (satTS: Int, sunTS: Int) {
    // let todayDate = NSDate()
    // let todayStr = todayDate.formatTo(format)
    //
    // let todaySimpleDate = NSDate().dateFromString(todayStr)
    //
    // // 星期六的时间戳(不含毫秒)
    // var satTS = 0
    // // 星期天的时间戳(不含毫秒)
    // var sunTS = 0
    //
    // // 判断是否是星期天
    // if todaySimpleDate.weekday == 1 {
    // satTS = Int(todaySimpleDate.dateByAddingDays(-1).timeIntervalSince1970)
    // sunTS = satTS + Int(D_DAY * 2)
    // } else {
    // satTS = Int(todaySimpleDate.dateByAddingDays(7 - todaySimpleDate.weekday).timeIntervalSince1970)
    // sunTS = satTS + Int(D_DAY * 2)
    // }
    //
    // return (satTS, sunTS)
    // }
    //
    // /// 在tabbarVC中获取当前选中的tabbar的当前UINavigationController
    // public var getCurrentNavVCInTabBar: BaseNavVC {
    // let selectIndex = homeNav!.cyl_tabBarController.selectedIndex
    // weak var tempVC = (homeNav!.cyl_tabBarController?.viewControllers![selectIndex] as! BaseNavVC)
    // return tempVC!
    // }
    //
    // /// 在tabbarVC中获取当前选中的tabbar的当前VC
    // public var getCurrentVCInTabBar: UIViewController {
    // return getCurrentNavVCInTabBar.viewControllers.last!
    // }
}
