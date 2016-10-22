//
//  ViewController.swift
//  YXJPullScaleTest
//
//  Created by yuanxiaojun on 16/8/11.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJPullScale

class ViewController: UITableViewController {
    
    fileprivate var headerView: MineHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 用户详情
        headerView = MineHeaderView()
        
        self.tableView.addPullScaleFunc(inVC: self, originalHeight: self.tableView.frame.size.width / (320.0 / 200.0), hasNavBar: false)
        
        self.tableView.scaleView.mainView = headerView
        self.tableView.scaleView.scaleImage = UIImageView(image: UIImage(named: "left_headerBg"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
