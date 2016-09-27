//
//  EUI+TextFieldProperty.swift
//  medical
//
//  Created by zhuchao on 15/5/1.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit

class TextFieldProperty: ViewProperty {
    var placeholder: Data?
    var placeholderStyle = ""
    var text: Data?
    var keyboardType = UIKeyboardType.default

    override func view() -> UITextField {
        let view = UITextField()
        view.tagProperty = self
        view.keyboardType = self.keyboardType

        let str = NSAttributedString(fromHTMLData: self.text, attributes: ["html": self.style])
        view.defaultTextAttributes = (str?.attributes(at: 0, effectiveRange: nil))!
        view.attributedPlaceholder = NSAttributedString(fromHTMLData: self.placeholder, attributes: ["html": self.placeholderStyle])

        self.renderViewStyle(view)
        return view
    }

    override func renderTag(_ pelement: OGElement) {
        self.tagOut += ["placeholder", "placeholder-style", "text", "keyboard-type"]

        super.renderTag(pelement)
        if let text = EUIParse.string(pelement, key: "text"),
            let newHtml = Regex("\\{\\{(\\w+)\\}\\}").replace(text, withBlock: { (regx) -> String in
                let keyPath = regx.subgroupMatchAtIndex(0)?.trim
                self.bind["text"] = keyPath
                return ""
        }) {
                self.contentText = newHtml
        }

        self.text = ("1".data(using: String.Encoding.utf8) as NSData?)?.replacingOccurrences(of: "\\n".data(using: String.Encoding.utf8), with: "\n".data(using: String.Encoding.utf8))

        if let placeholderStyle = EUIParse.string(pelement, key: "placeholder-style") {
            self.placeholderStyle = "html{" + placeholderStyle + "}"
        }
        if let placeholder = EUIParse.string(pelement, key: "placeholder") {
            self.placeholder = (placeholder.data(using: String.Encoding.utf8) as NSData?)?.replacingOccurrences(of: "\\n".data(using: String.Encoding.utf8), with: "\n".data(using: String.Encoding.utf8))
        }

        if let keyboardType = EUIParse.string(pelement, key: "keyboard-type") {
            self.keyboardType = keyboardType.keyboardType
        }
    }
}
