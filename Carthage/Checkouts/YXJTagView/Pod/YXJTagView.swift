//
//  YXJTagView.swift
//  YXJTagView
//
//  Created by 袁晓钧 16/1/25.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit

/**
 *  代理
 */
@objc public protocol YXJTagViewDelegate {
    @objc optional func didClickView(_ text: String, index: Int)
}

open class YXJTagView: UIView {
    /// 横向间距
    open var horizontalSpace: CGFloat = 10.0
    /// 纵向间距
    open var verticalSpace: CGFloat = 10.0
    /// 左边空隙距离
    open var margin: CGFloat = 0.0

    /// 标签文字------使用场景1:纯文字
    open var textData: [String]?
    /// 标签字体
    open var textFont = UIFont.systemFont(ofSize: 15)
    /// 标签文字颜色
    open var textColor = UIColor.white

    /// 标签图片------使用场景2:图片
    open var imageData: [UIImage]?
    /// 标签图片size,如果不设置，将根据高宽度自动适应
    open var imageSize: CGSize?

    /// 标签图片------使用场景3:视图
    open var viewData: [UIView]?
    /// 标签视图size,如果不设置，将根据高宽度自动适应
    open var viewSize: CGSize?

    /// 标签背景颜色
    open var textBackgorund = UIColor.lightGray
    /// 选中颜色
    open var selecteColor = UIColor.orange
    /// 是否可以选中,默认是
    open var selecteEnable = true

    ///
    open var title: String?
    ///
    open var titleFont = UIFont.systemFont(ofSize: 15)
    ///
    open var titleColor = UIColor.black

    /// 代理
    open var delegate: YXJTagViewDelegate?

    /// 是否是DEBUG模式
    open var debug = true

    fileprivate var btnClick: UIButton!
    fileprivate var label: UILabel?

    fileprivate var horizontalWidth: CGFloat = 0
    fileprivate var vertical: CGFloat = 0
    fileprivate var verticalHeight: CGFloat = 8
    fileprivate var index = -1

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func setupUI() {
        remove()
        if title != nil {
            setLabel(title!, titleFont: titleFont, titleColor: titleColor)
        }
        tagView(textFont, viewWidth: frame.width)
    }

    deinit {
        YXJLog("YXJTagView 已经被释放了")
    }
}

// MARK: - 点击方法
extension YXJTagView {

    func btnClick(_ sender: UIButton) {
        if btnClick == nil {
            btnClick = sender
        }
        if !btnClick.isEqual(sender) {
            btnClick.backgroundColor = textBackgorund
            btnClick.isSelected = false
        }
        sender.backgroundColor = selecteColor
        sender.isSelected = true
        btnClick = sender

        if let d = delegate {
            if let click = d.didClickView?(sender.currentTitle!, index: sender.tag - 100) {
                d.didClickView?(sender.currentTitle!, index: sender.tag - 100)
            } else {
                YXJLog("未实现YXJTagView > didClickView方法")
            }
        } else {
            YXJLog("未实现YXJTagView协议")
        }
    }
}

// MARK: - 私有方法
extension YXJTagView {
    fileprivate func setLabel(_ title: String, titleFont: UIFont, titleColor: UIColor) {
        label = UILabel()
        label!.text = title
        label!.textColor = titleColor
        label!.textAlignment = NSTextAlignment.left
        let size = NSString(string: title).size(attributes: [NSFontAttributeName: titleFont])
        label!.frame = CGRect(x: 10, y: 10, width: size.width + 20, height: size.height)
        addSubview(label!)
    }

    fileprivate func tagView(_ textFont: UIFont, viewWidth: CGFloat) {
        if textData != nil {
            for str in textData! {
                index += 1;
                let button = UIButton()
                let size = NSString(string: str).size(attributes: [NSFontAttributeName: textFont]);
//                self.setBtn(button, size: size, viewWidth: viewWidth, str: str)
                self.setTagViewFrame(nil, button: button, size: size, viewWidth: viewWidth, str: str)

                button.backgroundColor = textBackgorund
                button.layer.masksToBounds = true
                button.layer.cornerRadius = button.frame.height / 2
                button.clipsToBounds = true

                if index == textData!.count - 1 {
                    self.frame.size.height = button.frame.maxY + 10
                }
            }
        }
        if imageData != nil {
            for img in imageData! {
                index += 1;
                let button = UIButton()

                var size: CGSize!
                if imageSize != nil {
                    size = imageSize
                } else {
                    size = img.size
                }

//                self.setBtn(button,size: size,viewWidth: viewWidth,str: "")
                self.setTagViewFrame(nil, button: button, size: size, viewWidth: viewWidth, str: "")

                button.backgroundColor = textBackgorund
                button.setImage(img, for: UIControlState())

                if index == imageData!.count - 1 {
                    self.frame.size.height = button.frame.maxY + 10
                }
            }
        }
        if viewData != nil {
            for tempView in viewData! {
                index += 1;
                let button = UIButton()

                var size: CGSize!
                if viewSize != nil {
                    size = viewSize
                } else {
                    size = tempView.frame.size
                }

//                button.backgroundColor = textBackgorund
                self.setTagViewFrame(tempView, button: button, size: size, viewWidth: viewWidth, str: "")
//                button.setImage(img, forState: UIControlState.Normal)

                if index == viewData!.count - 1 {
                    self.frame.size.height = button.frame.maxY + 10
                }
            }
        }
    }

    fileprivate func setTagViewFrame(_ view1: UIView?, button: UIButton, size: CGSize, viewWidth: CGFloat, str: String) {
        button.frame.size.width = size.width + 10
        button.frame.size.height = size.height + 5
        if index == 0 {
            button.frame.origin.x = margin
        } else {
            button.frame.origin.x = horizontalWidth + horizontalSpace
        }
        button.frame.origin.y = verticalHeight

        if button.frame.origin.x + button.frame.size.width > viewWidth {
            horizontalWidth = 0
            vertical += 1
            button.frame.origin.x = margin

            if verticalHeight < button.frame.size.height + button.frame.origin.y + verticalSpace {
                verticalHeight = button.frame.size.height + button.frame.origin.y + verticalSpace
                button.frame.origin.y = verticalHeight
            }
        }

        if label != nil {
            button.frame.origin.y = label!.frame.maxY + button.frame.origin.y
        }
        horizontalWidth = button.frame.maxX

        button.setTitle(str, for: UIControlState())
        button.titleLabel?.font = textFont
        button.addTarget(self, action: #selector(YXJTagView.btnClick(_:)), for: .touchUpInside)

        button.setTitleColor(textColor, for: UIControlState())
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button.isUserInteractionEnabled = true
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.isEnabled = selecteEnable
        button.tag = 100 + index

        view1?.frame = button.frame
        if let v = view1 {
            addSubview(v)
        }

        addSubview(button)

//        view1.frame.size.width = size.width + 10
//        view1.frame.size.height = size.height + 5
//        if index == 0 {
//            view1.frame.origin.x = margin
//        } else {
//            view1.frame.origin.x = horizontalWidth + horizontalSpace
//        }
//        view1.frame.origin.y = verticalHeight
//
//        if view1.frame.origin.x + view1.frame.size.width > viewWidth {
//            horizontalWidth = 0
//            vertical++
//            view1.frame.origin.x = margin
//
//            if verticalHeight < view1.frame.size.height + view1.frame.origin.y + verticalSpace {
//                verticalHeight = view1.frame.size.height + view1.frame.origin.y + verticalSpace
//                view1.frame.origin.y = verticalHeight
//            }
//        }
//
//        horizontalWidth = CGRectGetMaxX(view1.frame)
    }

//    private func setBtn(button: UIButton, size: CGSize, viewWidth: CGFloat, str: String) {
//        button.frame.size.width = size.width + 10
//        button.frame.size.height = size.height + 5
//        if index == 0 {
//            button.frame.origin.x = margin
//        } else {
//            button.frame.origin.x = horizontalWidth + horizontalSpace
//        }
//        button.frame.origin.y = verticalHeight
//
//        if button.frame.origin.x + button.frame.size.width > viewWidth {
//            horizontalWidth = 0
//            vertical++
//            button.frame.origin.x = margin
//
//            if verticalHeight < button.frame.size.height + button.frame.origin.y + verticalSpace {
//                verticalHeight = button.frame.size.height + button.frame.origin.y + verticalSpace
//                button.frame.origin.y = verticalHeight
//            }
//        }
//
//        if label != nil {
//            button.frame.origin.y = CGRectGetMaxY(label!.frame) + button.frame.origin.y
//        }
//        horizontalWidth = CGRectGetMaxX(button.frame)
//
//        button.setTitle(str, forState: .Normal)
//        button.titleLabel?.font = textFont
//        button.addTarget(self, action: #selector(YXJTagView.btnClick(_:)), forControlEvents: .TouchUpInside)
//
//        button.setTitleColor(textColor, forState: .Normal)
//        button.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
//        button.userInteractionEnabled = true
//        button.titleLabel?.textAlignment = NSTextAlignment.Center
//        button.enabled = selecteEnable
//        button.tag = 100 + index
//        addSubview(button)
//    }

    fileprivate func remove() {
        for subV in subviews {
            subV.removeFromSuperview()
        }
    }

    override open func removeFromSuperview() {
        remove()
        super.removeFromSuperview()
    }

    fileprivate func YXJLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        if debug == true {
            let str: String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
            print("\(str)\(methodName)[\(lineNumber)]:\(message)")
        }
    }
}
