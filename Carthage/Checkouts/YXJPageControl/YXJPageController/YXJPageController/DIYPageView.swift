//
//  DIYPageView.swift
//  YXJPageControllerTest
//
//  Created by yuanxiaojun on 16/8/11.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJPageController

class DIYPageView: YXJAbstractDotView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.blue
    }

    override func changeActivityState(_ active: Bool) {
        if active == true {
            self.backgroundColor = UIColor.red
        } else {
            self.backgroundColor = UIColor.blue
        }
    }

}
