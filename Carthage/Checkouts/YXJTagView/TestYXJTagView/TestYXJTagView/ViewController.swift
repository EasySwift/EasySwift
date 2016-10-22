//
//  ViewController.swift
//  TestYXJTagView
//
//  Created by yuanxiaojun on 16/7/2.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJTagView

class ViewController: UIViewController, YXJTagViewDelegate {

    fileprivate var tagView: YXJTagView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tagView = YXJTagView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 20))
        self.view.addSubview(tagView)
        tagView.title = "标题"
        tagView.textColor = UIColor.gray
        tagView.textBackgorund = UIColor.gray.withAlphaComponent(0.6)
        tagView.selecteColor = UIColor.red
        tagView.horizontalSpace = 10.0
        tagView.verticalSpace = 5.0
        tagView.margin = 15.0
        tagView.delegate = self

        // 场景一,纯文字
//        tagView.textData = ["aa", "bbb", "cccc", "ddddd", "eeeeee", "fffffff", "gggggggg"]

        // 场景二,纯图片
//        tagView.imageData = [UIImage.init(named: "1")!, UIImage.init(named: "2")!, UIImage.init(named: "3")!, UIImage.init(named: "4")!, UIImage.init(named: "5")!]

        // 场景三,纯图片加自定义图片大小
//        tagView.imageData = [UIImage.init(named: "1")!, UIImage.init(named: "2")!, UIImage.init(named: "3")!, UIImage.init(named: "4")!, UIImage.init(named: "5")!]
//        tagView.imageSize = CGSizeMake((self.view.frame.size.width - 60) / 2, (self.view.frame.size.width - 60) / 2 * (110 / 280))

        // 场景四,任意视图，颜色必须设置为可见颜色
//        tagView.viewData = viewData()
//        tagView.textBackgorund = UIColor.clearColor()
//        tagView.selecteColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)

        // 场景五,任意视图，自定义大小，颜色必须设置为可见颜色
        tagView.viewData = viewData()
        tagView.viewSize = CGSize(width: (self.view.frame.size.width - 60) / 2, height: 80)
        tagView.textBackgorund = UIColor.clear
        tagView.selecteColor = UIColor.white.withAlphaComponent(0.6)

        tagView.setupUI()
    }

    func viewData() -> [UIView] {
        var views = [UIView]()

        let v1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v1.backgroundColor = UIColor.brown
        views.append(v1)

        let img1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img1.image = UIImage.init(named: "1")
        v1.addSubview(img1)

        let v2 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v2.backgroundColor = UIColor.brown
        views.append(v2)

        let img2 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img2.image = UIImage.init(named: "2")
        v2.addSubview(img2)

        let v3 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v3.backgroundColor = UIColor.brown
        views.append(v3)

        let img3 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img3.image = UIImage.init(named: "3")
        v3.addSubview(img3)

        return views
    }

    func didClickView(_ text: String, index: Int) {
        print("index \(index)")
        print("text \(text)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

