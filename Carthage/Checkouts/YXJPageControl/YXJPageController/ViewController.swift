//
//  ViewController.swift
//  YXJPageController
//
//  Created by yuanxiaojun on 16/8/11.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJPageController_iOS

var ScreenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

class ViewController: UIViewController {

    fileprivate var pageController1 = YXJPageControl(frame: CGRect(x: 50, y: 100, width: 200, height: 20))
    fileprivate var pageController2 = YXJPageControl(frame: CGRect(x: 50, y: 150, width: 200, height: 20))
    fileprivate var pageController3 = YXJPageControl(frame: CGRect(x: 50, y: 200, width: 200, height: 20))
    fileprivate var pageController4 = YXJPageControl(frame: CGRect(x: 50, y: 250, width: 200, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         第一种，使用默认设置
         */
        pageController1.backgroundColor = UIColor.groupTableViewBackground
        pageController1.numberOfPages = 5
        self.view.addSubview(pageController1)

        /**
         第二种，自定义大小和颜色以及间距
         */
        pageController2.backgroundColor = UIColor.groupTableViewBackground
        pageController2.dotSize = CGSize(width: 15, height: 15)
        pageController2.dotColor = UIColor.magenta
        pageController2.spacingBetweenDots = 15
        pageController2.numberOfPages = 5
        self.view.addSubview(pageController2)

        /**
         第三种，使用图片替换小圆点
         */
        pageController3.backgroundColor = UIColor.groupTableViewBackground
        pageController3.dotImage = UIImage(named: "1")
        pageController3.currentDotImage = UIImage(named: "2")
        pageController3.numberOfPages = 5
        self.view.addSubview(pageController3)

        /**
         第四种，继承YXJAbstractDotView，自定义小圆点样式
         */
        pageController4.backgroundColor = UIColor.groupTableViewBackground
        pageController4.numberOfPages = 5
        pageController4.dotViewClass = DIYPageView.classForCoder()
        self.view.addSubview(pageController4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

