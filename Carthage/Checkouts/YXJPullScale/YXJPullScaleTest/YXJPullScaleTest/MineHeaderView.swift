//
//  MineHeaderView.swift
//  diDaRecruit
//
//  Created by yuanxiaojun on 16/7/14.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJXibView

class MineHeaderView: YXJXibView {

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var phoneLab: UILabel!

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    fileprivate func initView() {
        self.logoImg.backgroundColor = UIColor.yellow
        self.logoImg.layer.masksToBounds = true
        self.logoImg.layer.cornerRadius = self.logoImg.frame.size.width / 2
    }
}
