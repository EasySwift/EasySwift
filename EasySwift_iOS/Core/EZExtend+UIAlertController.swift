//
//  EZExtend+UIAlertController.swift
//  medical
//
//  Created by zhuchao on 15/4/28.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit

// MARK: - UIAlertController

public func alert (_ title: String,
    message: String,
    cancelAction: ((UIAlertAction?)->Void)? = nil,
    okAction: ((UIAlertAction?)->Void)? = nil) -> UIAlertController {
        let a = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        if let ok = okAction {
            a.addAction(UIAlertAction(title: "OK", style: .default, handler: ok))
            a.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelAction))
        } else {
            a.addAction(UIAlertAction(title: "OK", style: .cancel, handler: cancelAction))
        }
        
        return a
}
