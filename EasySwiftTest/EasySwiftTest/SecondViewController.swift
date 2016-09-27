//
//  SecondViewController.swift
//  EasySwiftTest
//
//  Created by yuanxiaojun on 16/6/5.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasySwift
import ZLPhotoBrowser

class SecondViewController: UITableViewController {

    lazy var actionSheet = ZLPhotoActionSheet()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

//        self.navigationController!.navigationBar.tintColor = UIColor.magentaColor()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController!.navigationBar.layer.masksToBounds = false
        self.navigationController!.navigationBar.barTintColor = UIColor.red.withAlphaComponent(0.5)

//        kViewHeight = UIScreen.mainScreen().bounds.size.height - 64

//        kViewHeight [[UIScreen mainScreen] bounds].size.height - 64

        let img = UIImageView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        self.view.addSubview(img)

        self.view.whenTap {
            // 初始化相册选取
            // 设置照片最大选择数
            self.actionSheet.maxSelectCount = 1
            // 设置照片最大预览数
            self.actionSheet.maxPreviewCount = 20
            self.actionSheet.show(withSender: self, animate: true, last: nil, completion: { (imgs, selectImgs) in
                img.image = imgs.first
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

