//
//  ViewController.swift
//  YXJImageCompressorTest
//
//  Created by yuanxiaojun on 16/8/11.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJImageCompressor

class ViewController: UIViewController {

    var ScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var ScreenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tv = UITextView(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: ScreenHeight - 20))
        tv.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tv)

        /// 原图
        let oldImg = UIImage(named: "img.JPG")
        let oldData = UIImageJPEGRepresentation(oldImg!, 0.7)

        tv.text.append("原图大小 \(M(Double(oldData!.count))) M \n")
        tv.text.append("原图宽度 \(oldImg?.size.width) \n")
        tv.text.append("原图高度 \(oldImg?.size.height) \n\n")
        tv.text.append("-------------------------------\n")

        /// 压缩方式一：最大边不超过某个值等比例压缩
        let px_1000_img = YXJImageCompressor.yxjImage(with: _1000PX, sourceImage: oldImg)
        let px_1000_data = UIImageJPEGRepresentation(px_1000_img!, 0.7)

        tv.text.append("最大边不超过1000PX的大小 \(M(Double(px_1000_data!.count))) M \n")
        tv.text.append("最大边不超过1000PX宽度 \(px_1000_img?.size.width)\n")
        tv.text.append("最大边不超过1000PX高度 \(px_1000_img?.size.height)\n\n")
        tv.text.append("-------------------------------\n")

        let px_100_img = YXJImageCompressor.yxjImage(with: _100PX, sourceImage: oldImg)
        let px_100_data = UIImageJPEGRepresentation(px_100_img!, 0.7)

        tv.text.append("最大边不超过100PX的大小 \(M(Double(px_100_data!.count))) M\n")
        tv.text.append("最大边不超过100PX宽度 \(px_100_img?.size.width)\n")
        tv.text.append("最大边不超过100PX高度 \(px_100_img?.size.height)\n\n")
        tv.text.append("-------------------------------\n")

        /// 压缩方式二：图片大小不超过某个值已经最大边不超过某个像素等比例压缩
        YXJImageCompressor.yxjCompressImage(oldImg, limitSize: _1M, maxSide: _1000PX) { (data) in
            let img = UIImage(data: data!)
            tv.text.append("图片最大值不超过最大边1M 以及 最大边不超过1000PX的大小 \(self.M(Double((data?.count)!))) M\n")
            tv.text.append("图片最大值不超过最大边1M 以及 最大边不超过1000PX的宽度 \(img!.size.width)\n")
            tv.text.append("图片最大值不超过最大边1M 以及 最大边不超过1000PX的高度 \(img!.size.height)\n\n")
            tv.text.append("-------------------------------\n")
        }

        YXJImageCompressor.yxjCompressImage(oldImg, limitSize: _64K, maxSide: _100PX) { (data) in
            let img = UIImage(data: data!)
            tv.text.append("图片最大值不超过最大边64K 以及 最大边不超过100PX的大小 \(self.M(Double((data?.count)!))) M\n")
            tv.text.append("图片最大值不超过最大边64K 以及 最大边不超过100PX的宽度 \(img!.size.width)\n")
            tv.text.append("图片最大值不超过最大边64K 以及 最大边不超过100PX的高度 \(img!.size.height)\n\n")
        }
    }

    func M(_ k: Double) -> Double {
        return k / Double(_1M.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

