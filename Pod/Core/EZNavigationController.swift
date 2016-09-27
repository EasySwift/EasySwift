//
//  EZNavigationController.swift
//  medical
//
//  Created by zhuchao on 15/4/24.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit

open class EZNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    open var popGestureRecognizerEnabled = true

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.configGestureRecognizer()
        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    open func configGestureRecognizer() {
        if let target = self.interactivePopGestureRecognizer?.delegate {
            let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
            pan.delegate = self
            self.view.addGestureRecognizer(pan)
        }
        // 禁掉系统的侧滑手势
        weak var weekSelf = self
        self.interactivePopGestureRecognizer?.isEnabled = false;
        self.interactivePopGestureRecognizer?.delegate = weekSelf;
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer != self.interactivePopGestureRecognizer && self.viewControllers.count > 1 && self.popGestureRecognizerEnabled {
            return true
        } else {
            return false
        }
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = false
        super.pushViewController(viewController, animated: animated)
    }

    // UINavigationControllerDelegate
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.popGestureRecognizerEnabled {
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
