//
//  ViewController.swift
//  YXJLinksButton
//
//  Created by yuanxiaojun on 2016/11/3.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJLinksButton_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = YXJLinksButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.setTitle("用户协议", for: UIControlState())
        btn.setTitleColor(UIColor.black, for: UIControlState())
        
        // 设置下划线颜色
        btn.setLinksColor(UIColor.red)
        
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

