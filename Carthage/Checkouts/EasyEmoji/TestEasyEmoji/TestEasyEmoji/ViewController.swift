//
//  ViewController.swift
//  EasyEmoji
//
//  Created by yuanxiaojun on 16/6/14.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasyEmoji

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func textChange(_ sender: UITextField) {
        if let str = sender.text {
            print(containEmoji(str))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

