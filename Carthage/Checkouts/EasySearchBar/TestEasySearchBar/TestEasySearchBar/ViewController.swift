//
//  ViewController.swift
//  TestEasySearchBar
//
//  Created by yuanxiaojun on 16/7/1.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasySearchBar

class ViewController: UIViewController {

    fileprivate var searchBar: EasySearchBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 搜索框
        self.searchBar = EasySearchBar(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 30))
        self.searchBar?.easySearchBarPlaceholder = "搜索课程"
        self.searchBar?.easyBackgroundColor = UIColor.cyan
        self.view.addSubview(self.searchBar!)

        self.searchBar?.easyCancelBTClickedBlock({ (search) in
            print("点击了取消按钮")
            search?.text = ""
        })
        self.searchBar?.easySearchBarTextDidBeginEditing({ (search) in
            print("开始编辑" + (search?.text!)!)
        })
        self.searchBar?.easySearchBarTextDidChange({ (search, searchText) in
            print("内容改变" + searchText!)
        })
        self.searchBar?.easySearchBarTextDidEndEditing({ (search) in
            print("结束输入")
        })
        self.searchBar?.easySearchBarSearchButtonClickedBlock({ (search) in
            print("点击键盘搜索" + (search?.text!)!)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

