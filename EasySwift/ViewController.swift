//
//  ViewController.swift
//  EasySwift
//
//  Created by yuanxiaojun on 2016/10/30.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasySwift_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aa = YXJTagView.init(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        print(aa)
        
        let bb = YXJSwipeTableViewCell(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        print(bb)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

