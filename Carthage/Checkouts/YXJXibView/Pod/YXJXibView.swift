//
//  YXJXibView.swift
//  YXJXibView
//
//  Created by 袁晓钧 on 16/7/4.
//

import Foundation
import UIKit

public protocol NibDefinable {
    var nibName: String { get }
}

public extension NibDefinable {
    var nibName: String {
        return String(describing: type(of: self))
    }
}

@objc open class YXJXibView: UIView, NibDefinable {

    @IBOutlet weak var view: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromXib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = UIColor.clear
        addSubview(view)
    }

    fileprivate func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
