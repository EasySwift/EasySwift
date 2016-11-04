//
//  EZExtend+NSDate.swift
//  medical
//
//  Created by zhuchao on 15/5/9.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation

extension Date {
    //format :yyyy-MM-dd
    public func formatTo(_ format:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let currentDateStr = dateFormatter.string(from: self)
        return currentDateStr
    }
}
