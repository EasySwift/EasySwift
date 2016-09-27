//
//  YXJLinksButton.swift
//  whoRent
//
//  Created by yuanxiaojun on 16/3/1.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit

open class YXJLinksButton: UIButton {

    fileprivate var linksColor = UIColor.white

    open func setLinksColor(_ color: UIColor) {
        self.linksColor = color
        self.setNeedsDisplay()
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        let textRect = self.titleLabel!.frame
        let contextRef = UIGraphicsGetCurrentContext()

        let descender = self.titleLabel!.font.descender
        if (self.linksColor.isKind(of: UIColor.self)) {
            contextRef?.setStrokeColor(linksColor.cgColor)
        }

        contextRef?.move(to: CGPoint(x: textRect.origin.x, y: textRect.origin.y + textRect.size.height + descender + 3))
        contextRef?.addLine(to: CGPoint(x: textRect.origin.x + textRect.size.width, y: textRect.origin.y + textRect.size.height + descender + 3))

        contextRef?.closePath()
        contextRef?.drawPath(using: CGPathDrawingMode.stroke) // kCGPathStroke)
    }
}
