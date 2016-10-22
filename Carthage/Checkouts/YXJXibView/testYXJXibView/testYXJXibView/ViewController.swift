//
//  ViewController.swift
//  testYXJXibView
//
//  Created by yuanxiaojun on 16/7/4.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJXibView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 方式一:在storyBoard中自动生成

        // 方式二:代码生成
        let v2 = TestXibView2(frame: CGRect(x: 50, y: 300, width: 50, height: 50))
        self.view.addSubview(v2)

        // 方式二:代码生成
        let v3 = TestXibView3(frame: CGRect(x: 50, y: 500, width: 50, height: 50))
        self.view.addSubview(v3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

