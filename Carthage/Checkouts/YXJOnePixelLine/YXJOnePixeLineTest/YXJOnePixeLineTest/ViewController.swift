//
//  ViewController.swift
//  YXJOnePixeLineTest
//
//  Created by yuanxiaojun on 16/8/10.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJOnePixeLine

class ViewController: UIViewController {

    @IBOutlet weak var onePixeView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func click(_ sender: AnyObject) {
        // linePosition的按照顺时针的方向，依次对应 上>右>下>左

        // 上
        let pixe1 = YXJOnePixelLine(frame: onePixeView.frame,
                                    lineColor: UIColor.red,
                                    linePosition: 0)
        self.onePixeView.addSubview(pixe1!)

        // 右
        let pixe2 = YXJOnePixelLine(frame: onePixeView.frame,
                                    lineColor: UIColor.red,
                                    linePosition: 1)
        self.onePixeView.addSubview(pixe2!)
        
        // 下
        let pixe3 = YXJOnePixelLine(frame: onePixeView.frame,
                                    lineColor: UIColor.red,
                                    linePosition: 2)
        self.onePixeView.addSubview(pixe3!)
        
        // 左
        let pixe4 = YXJOnePixelLine(frame: onePixeView.frame,
                                    lineColor: UIColor.red,
                                    linePosition: 3)
        self.onePixeView.addSubview(pixe4!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

