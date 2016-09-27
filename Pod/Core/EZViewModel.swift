//
//  EZViewModel.swift
//  medical
//
//  Created by zhuchao on 15/5/11.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import Bond

open class EZData: NSObject {
    open var dym: Observable<Data>?

    open var value: Data? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }

    public init(_ data: Data) {
        self.dym = Observable<Data>(data)
    }
}

open class EZString: NSObject {
    open var dym: Observable<String>?

    open var value: String? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }

    public init(_ str: String) {
        self.dym = Observable<String>(str)
    }
}

open class EZURL: NSObject {
    open var dym: Observable<URL?>?
    open var value: URL? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ url: URL?) {
        self.dym = Observable<URL?>(url)
    }
}

open class EZAttributedString: NSObject {
    open var dym: Observable<NSAttributedString>?
    open var value: NSAttributedString? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ str: NSAttributedString) {
        self.dym = Observable<NSAttributedString>(str)
    }
}

open class EZImage: NSObject {
    open var dym: Observable<UIImage?>?
    open var value: UIImage? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ image: UIImage?) {
        self.dym = Observable<UIImage?>(image)
    }
}

open class EZColor: NSObject {
    open var dym: Observable<UIColor>?
    open var value: UIColor? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ color: UIColor) {
        self.dym = Observable<UIColor>(color)
    }
}

open class EZBool: NSObject {
    open var dym: Observable<Bool>?
    open var value: Bool? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ b: Bool) {
        self.dym = Observable<Bool>(b)
    }
}

open class EZFloat: NSObject {
    open var dym: Observable<CGFloat>?
    open var value: CGFloat? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ fl: CGFloat) {
        self.dym = Observable<CGFloat>(fl)
    }
}

open class EZInt: NSObject {
    open var dym: Observable<Int>?
    open var value: Int? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ i: Int) {
        self.dym = Observable<Int>(i)
    }
}

open class EZNumber: NSObject {
    open var dym: Observable<NSNumber>?
    open var value: NSNumber? {
        get {
            return self.dym?.value
        } set(value) {
            self.dym?.value = value!
        }
    }
    public init(_ i: NSNumber) {
        self.dym = Observable<NSNumber>(i)
    }
}

extension NSObject {
    public var model_properyies: Dictionary<String, AnyObject> {
        return self.listProperties()
    }

    public func model_hasKey(_ key: String) -> Bool {
        return self.model_properyies.keys.contains(key)
    }
}

open class EZViewModel: NSObject {

}
