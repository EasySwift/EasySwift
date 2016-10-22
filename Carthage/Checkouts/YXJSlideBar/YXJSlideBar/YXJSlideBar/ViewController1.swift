//
//  TableViewController.swift
//  YXJSlideBarTest
//
//  Created by yuanxiaojun on 16/8/10.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJSlideBar

class ViewController1: UIViewController, YXJSlideContentViewDataSource {

    fileprivate var slideBar: YXJSlideBar!

    fileprivate var contentView: YXJSlideContentView!

    fileprivate var vcs = [
        UIViewController(), UIViewController(),
        UIViewController(), UIViewController(),
        UIViewController(), UIViewController(),
        UIViewController(), UIViewController(),
        UIViewController(), UIViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 菜单2
        self.slideBar = YXJSlideBar(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 50))
        self.slideBar.backgroundColor = UIColor.groupTableViewBackground
        self.slideBar.itemsTitle = ["选项1", "选项2", "选项3", "选项4", "选项5", "选项6", "选项7", "选项8", "选项9", "选项10"]
        self.slideBar.itemColor = UIColor.gray
        self.slideBar.itemSelectedColor = UIColor.red
        self.slideBar.sliderColor = UIColor.red
        self.slideBar.slideBarItemSelectedCallback { [weak self](idx) -> Void in
            print(idx)
            self?.contentView.scroll(to: idx)
        }
        self.view.addSubview(self.slideBar)

        self.contentView = YXJSlideContentView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 300))
        self.contentView.dataSource = self
        self.contentView.setIsEnableScroll(true)
        self.contentView.slideContentViewScrollFinished { [weak self](idx) in
            print(idx)
            self?.slideBar.selectItem(at: idx)
        }
        self.view.addSubview(contentView)

        vcs[0].view.backgroundColor = UIColor.red
        vcs[1].view.backgroundColor = UIColor.black
        vcs[2].view.backgroundColor = UIColor.darkGray
        vcs[3].view.backgroundColor = UIColor.lightGray
        vcs[4].view.backgroundColor = UIColor.green
        vcs[5].view.backgroundColor = UIColor.blue
        vcs[6].view.backgroundColor = UIColor.cyan
        vcs[7].view.backgroundColor = UIColor.yellow
        vcs[8].view.backgroundColor = UIColor.magenta
        vcs[9].view.backgroundColor = UIColor.orange
    }

    // MARK:YXJSlideContentViewDataSource
    func slideContentView(_ contentView: YXJSlideContentView!, viewControllerFor index: UInt) -> UIViewController! {
        return vcs[Int(index)]
    }
    func numOfContentView() -> Int {
        return vcs.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
