//
//  ViewController.swift
//  YXJSlideBar
//
//  Created by yuanxiaojun on 16/8/10.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJSlideBar

class ViewController: UIViewController {

    fileprivate var slideBar1: YXJSlideBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 菜单1
        self.slideBar1 = YXJSlideBar(itemWidth: (ScreenWidth / 4), barHeight: 50)
        self.slideBar1.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 50)
        self.slideBar1.backgroundColor = UIColor.groupTableViewBackground
        self.slideBar1.itemsTitle = ["待接单", "已接单", "待付现", "已结算"]
        self.slideBar1.slideBarItemSelectedCallback { (idx) -> Void in
            print(idx)
        }
        self.view.addSubview(slideBar1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

