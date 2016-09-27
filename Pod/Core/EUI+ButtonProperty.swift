//
//  EUI+ButtonProperty.swift
//  medical
//
//  Created by zhuchao on 15/5/1.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit

class ButtonProperty: ViewProperty {

    var highlightedStyle = ""
    var disabledStyle = ""
    var selectedStyle = ""
    var applicationStyle = ""
    var reservedStyle = ""

    var highlightedText: String?
    var disabledText: String?
    var selectedText: String?
    var applicationText: String?
    var reservedText: String?
    var onEvent: SelectorAction?

    override func view() -> UIButton {
        let view = UIButton()
        view.tagProperty = self

        if self.style != "" {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.contentText?.toData() as Data!, attributes: ["html": self.style]), for: UIControlState())
        }

        if self.highlightedText != nil {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.highlightedText?.toData() as Data!, attributes: ["html": self.highlightedStyle]), for: UIControlState.highlighted)
        }

        if self.disabledText != nil {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.disabledText?.toData() as Data!, attributes: ["html": self.disabledStyle]), for: UIControlState.disabled)
        }

        if self.selectedText != nil {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.selectedText?.toData() as Data!, attributes: ["html": self.selectedStyle]), for: UIControlState.selected)
        }

        if self.applicationText != nil {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.applicationText?.toData() as Data!, attributes: ["html": self.applicationStyle]), for: UIControlState.application)
        }

        if self.reservedText != nil {
            view.setAttributedTitle(NSAttributedString(fromHTMLData: self.reservedText?.toData() as Data!, attributes: ["html": self.reservedStyle]), for: UIControlState.reserved)
        }

        self.renderViewStyle(view)
        return view
    }

    override func renderTag(_ pelement: OGElement) {

        self.tagOut += ["highlighted", "disabled", "selected", "application", "reserved", "disabled-text",
            "selected-text", "application-text", "reserved-text", "highlighted-text", "onevent"]

        super.renderTag(pelement)

        if let highlightedStyle = EUIParse.string(pelement, key: "highlighted") {
            self.highlightedStyle = "html{" + highlightedStyle + "}"
        }

        if let disabledStyle = EUIParse.string(pelement, key: "disabled") {
            self.disabledStyle = "html{" + disabledStyle + "}"
        }

        if let selectedStyle = EUIParse.string(pelement, key: "selected") {
            self.selectedStyle = "html{" + selectedStyle + "}"
        }

        if let applicationStyle = EUIParse.string(pelement, key: "application") {
            self.applicationStyle = "html{" + applicationStyle + "}"
        }

        if let reservedStyle = EUIParse.string(pelement, key: "reserved") {
            self.reservedStyle = "html{" + reservedStyle + "}"
        }

        self.disabledText = EUIParse.string(pelement, key: "disabled-text")
        self.selectedText = EUIParse.string(pelement, key: "selected-text")
        self.applicationText = EUIParse.string(pelement, key: "application-text")
        self.reservedText = EUIParse.string(pelement, key: "reserved-text")
        self.highlightedText = EUIParse.string(pelement, key: "highlighted-text")

        if let theSelector = EUIParse.string(pelement, key: "onevent") {
            var values = theSelector.trimArrayBy(":")
            if values.count == 2 {
                self.onEvent = SelectorAction(selector: values[1], event: values[0])
            }
        }

        var html = ""
        for child in pelement.children
        {
            html += (child as AnyObject).html().trim
        }
        if let newHtml = self.bindTheKeyPath(html, key: "text") {
            html = newHtml
        }
        self.contentText = html
    }

}
