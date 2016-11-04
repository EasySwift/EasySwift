//
//  DeviceKit.swift
//  Pods
//
//  Created by yuanxiaojun on 16/8/11.
//
//

import UIKit

open class DeviceKit: NSObject {

    /**
     打电话

     - parameter phone: 手机号
     */
    open func callPhone(_ phone: String) {
        let url = URL(string: "tel://" + phone)
        UIApplication.shared.openURL(url!)
    }
}
