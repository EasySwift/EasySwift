//
//  EZBond.swift
//  medical
//
//  Created by zhuchao on 15/4/27.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Bond
import TTTAttributedLabel
import Kingfisher_iOS
import ReactiveKit

@objc class TapGestureDynamicHelper: NSObject
{
    weak var view: UIView?
    let sink: (UITapGestureRecognizer) -> Void
    init(view: UIView, number: NSInteger, sink: @escaping ((UITapGestureRecognizer) -> Void)) {
        self.view = view
        self.sink = sink
        super.init()
        view.addTapGesture(number, target: self, action: #selector(TapGestureDynamicHelper.tapHandle(_:)))
    }

    func tapHandle(_ gesture: UITapGestureRecognizer) {
        sink(gesture)
    }
}

@objc class PanGestureDynamicHelper: NSObject {
    weak var view: UIView?
    let sink: (UIPanGestureRecognizer) -> Void
    init(view: UIView, number: NSInteger, sink: @escaping ((UIPanGestureRecognizer) -> Void)) {
        self.view = view
        self.sink = sink
        super.init()
        view.addPanGesture(self, action: #selector(PanGestureDynamicHelper.panHandle(_:)))
    }
    func panHandle(_ gestureRecognizer: UIPanGestureRecognizer) {
        sink(gestureRecognizer)
    }
}

@objc class SwipeGestureDynamicHelper: NSObject
{
    weak var view: UIView?
    let sink: ((UISwipeGestureRecognizer) -> Void)
    var number: NSInteger = 1
    init(view: UIView, number: NSInteger, sink: @escaping ((UISwipeGestureRecognizer) -> Void)) {
        self.view = view
        self.number = number
        self.sink = sink
        super.init()
        view.addSwipeGesture(UISwipeGestureRecognizerDirection.right, numberOfTouches: number, target: self, action: #selector(SwipeGestureDynamicHelper.swipeRightHandle(_:)))
        view.addSwipeGesture(UISwipeGestureRecognizerDirection.up, numberOfTouches: number, target: self, action: #selector(SwipeGestureDynamicHelper.swipeUpHandle(_:)))
        view.addSwipeGesture(UISwipeGestureRecognizerDirection.down, numberOfTouches: number, target: self, action: #selector(SwipeGestureDynamicHelper.swipeDownHandle(_:)))
        view.addSwipeGesture(UISwipeGestureRecognizerDirection.left, numberOfTouches: number, target: self, action: #selector(SwipeGestureDynamicHelper.swipeLeftHandle(_:)))
    }

    func swipeRightHandle(_ gestureRecognizer: UISwipeGestureRecognizer) {
        sink(gestureRecognizer)
    }
    func swipeUpHandle(_ gestureRecognizer: UISwipeGestureRecognizer) {
        sink(gestureRecognizer)
    }
    func swipeDownHandle(_ gestureRecognizer: UISwipeGestureRecognizer) {
        sink(gestureRecognizer)
    }
    func swipeLeftHandle(_ gestureRecognizer: UISwipeGestureRecognizer) {
        sink(gestureRecognizer)
    }
}

extension UIView {
    fileprivate struct AssociatedKeys {
        static var PanGestureEventKey = "bnd_PanGestureEventKey"
        static var PanGestureEventHelperKey = "bnd_PanGestureEventHelperKey"
        static var SwipeGestureEventKey = "bnd_SwipeGestureEventKey"
        static var SwipeGestureEventHelperKey = "bnd_SwipeGestureEventHelperKey"
        static var TapGestureEventKey = "bnd_TapGestureEventKey"
        static var TapGestureEventHelperKey = "bnd_TapGestureEventHelperKey"

    }

//    public func bnd_swipeGestureEvent(_ number: NSInteger) -> EventProducer<UISwipeGestureRecognizer> {
//        if let bnd_swipeGestureEvent: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.SwipeGestureEventKey) as AnyObject? {
//            return bnd_swipeGestureEvent as! EventProducer<UISwipeGestureRecognizer>
//        } else {
//            var capturedSink: ((UISwipeGestureRecognizer) -> ())! = nil
//            let bnd_swipeGestureEvent = EventProducer<UISwipeGestureRecognizer> { sink in
//                capturedSink = sink
//                return nil
//            }
//            let controlHelper = SwipeGestureDynamicHelper(view: self, number: number, sink: capturedSink)
//            objc_setAssociatedObject(self, &AssociatedKeys.SwipeGestureEventHelperKey, controlHelper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            objc_setAssociatedObject(self, &AssociatedKeys.SwipeGestureEventKey, bnd_swipeGestureEvent, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return bnd_swipeGestureEvent
//        }
//    }
//
//    public func bnd_tapGestureEvent(_ number: NSInteger) -> EventProducer<UITapGestureRecognizer> {
//        if let bnd_tapGestureEvent: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.TapGestureEventKey) as AnyObject? {
//            return bnd_tapGestureEvent as! EventProducer<UITapGestureRecognizer>
//        } else {
//            var capturedSink: ((UITapGestureRecognizer) -> ())! = nil
//            let bnd_tapGestureEvent = EventProducer<UITapGestureRecognizer> { sink in
//                capturedSink = sink
//                return nil
//            }
//            let controlHelper = TapGestureDynamicHelper(view: self, number: number, sink: capturedSink)
//            objc_setAssociatedObject(self, &AssociatedKeys.TapGestureEventHelperKey, controlHelper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            objc_setAssociatedObject(self, &AssociatedKeys.TapGestureEventKey, bnd_tapGestureEvent, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return bnd_tapGestureEvent
//        }
//    }
//
//    public var bnd_panGestureEvent: EventProducer<UIPanGestureRecognizer> {
//        if let bnd_panGestureEvent: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.PanGestureEventKey) as AnyObject? {
//            return bnd_panGestureEvent as! EventProducer<UIPanGestureRecognizer>
//        } else {
//            var capturedSink: ((UIPanGestureRecognizer) -> ())! = nil
//            let bnd_panGestureEvent = EventProducer<UIPanGestureRecognizer> { sink in
//                capturedSink = sink
//                return nil
//            }
//            let controlHelper = PanGestureDynamicHelper(view: self, number: 1, sink: capturedSink)
//            objc_setAssociatedObject(self, &AssociatedKeys.PanGestureEventHelperKey, controlHelper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            objc_setAssociatedObject(self, &AssociatedKeys.PanGestureEventKey, bnd_panGestureEvent, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return bnd_panGestureEvent
//        }
//    }
}

//extension UIImageView {
//    fileprivate struct AssociatedKeys {
//        static var UrlImageDynamicHandleUIImageView = "UrlImageDynamicHandleUIImageView"
//    }
//    public var bnd_URLImage: Observable<URL?> {
//        if let d: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.UrlImageDynamicHandleUIImageView) as AnyObject? {
//            return (d as? Observable<URL?>)!
//        } else {
//            let d = Observable<URL?>(URL())
//            d.observe { [weak self] v in if let s = self {
//                if v != nil {
//                    s.kf_setImageWithURL(v!)
//                }
//            } }
//            objc_setAssociatedObject(self, &AssociatedKeys.UrlImageDynamicHandleUIImageView, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return d
//        }
//    }
//}

extension TTTAttributedLabel {
    fileprivate struct AssociatedKeys {
        static var textDynamicHandleTTTAttributeLabel = "textDynamicHandleTTTAttributeLabel"
        static var attributedTextDynamicHandleTTTAttributeLabel = "attributedTextDynamicHandleTTTAttributeLabel"
        static var dataDynamicHandleTTTAttributeLabel = "dataDynamicHandleTTTAttributeLabel"
    }

    public var dynTTText: Observable<String> {
        if let d: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.textDynamicHandleTTTAttributeLabel) as AnyObject? {
            return (d as? Observable<String>)!
        } else {
            let d = Observable<String>(self.text ?? "")
            d.observe { [weak self] v in if let s = self {
                s.setText(v)
            } }
            objc_setAssociatedObject(self, &AssociatedKeys.textDynamicHandleTTTAttributeLabel, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return d
        }
    }

//    public var dynTTTData: Observable<Data> {
//        if let d: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.dataDynamicHandleTTTAttributeLabel) as AnyObject? {
//            return (d as? Observable<Data>)!
//        } else {
//            let d = Observable<Data>(Data())
//            d.observe { [weak self] v in if let s = self {
//                s.setText(NSAttributedString(fromHTMLData: v, attributes: ["dict": s.tagProperty.style]))
//            } }
//            objc_setAssociatedObject(self, &AssociatedKeys.dataDynamicHandleTTTAttributeLabel, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return d
//        }
//    }

    public var dynTTTAttributedText: Observable<NSAttributedString> {
        if let d: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.attributedTextDynamicHandleTTTAttributeLabel) as AnyObject? {
            return (d as? Observable<NSAttributedString>)!
        } else {
            let d = Observable<NSAttributedString>(self.attributedText ?? NSAttributedString(string: ""))
            d.observe { [weak self] v in if let s = self {
                s.setText(v) } }
            objc_setAssociatedObject(self, &AssociatedKeys.attributedTextDynamicHandleTTTAttributeLabel, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return d
        }
    }

}
