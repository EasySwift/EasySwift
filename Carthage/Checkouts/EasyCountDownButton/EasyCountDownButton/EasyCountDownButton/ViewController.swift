//
//  ViewController.swift
//  EasyCountDownButton
//
//  Created by yuanxiaojun on 16/8/10.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasyCountDown_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = EasyCountDownButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        
        btn.disableConfig = EasyCountDownButtonConfig(
            font: UIFont.systemFont(ofSize: 14),
            title: "剩余 5 秒",
            titleColor: UIColor.gray,
            backgroundColor: UIColor.groupTableViewBackground,
            backgroundImage: nil)

        btn.enableConfig = EasyCountDownButtonConfig(
            font: UIFont.systemFont(ofSize: 14),
            title: "获取验证码",
            titleColor: UIColor.magenta,
            backgroundColor: UIColor.blue,
            backgroundImage: nil)

        self.view.addSubview(btn)

        // 点击事件  button type要 设置成custom 否则会闪动
        btn.addToucheHandler { (btn, second) in
            btn?.start(withSecond: 5)
        }

        // 时间改变
        btn.didChange { (btn, second) -> String! in
            return "剩余 \(second) 秒"
        }

        // 时间结束
        btn.didFinished { (btn, second) in
            print(btn)
            print(second)
        }

        // 手动停止
//        btn.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

