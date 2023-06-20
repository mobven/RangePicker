//
//  RangePickerViewNib.swift
//  RangePickerView
//
//  Created by Rashid Ramazanov on 8/15/22.
//  Copyright © 2022 Mobven. All rights reserved.
//

import Foundation
import UIKit

extension RangePickerView {
    func setupNib() {
        let view = fromNib()
        addSubview(pinningView: view)
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func fromNib() -> UIView {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else {
            fatalError("nibName not found")
        }

        let nib = UINib(nibName: nibName, bundle: Bundle.module)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("View not found")
        }

        return view
    }
}

extension UIView {
    /// Add subview to view and set constraints to fit all bounds.
    /// - Parameter view: To be added as subview.
    func addSubview(pinningView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.pinView(self)
    }

    /// Sets constraints the specified view to fit all bounds.
    /// - Parameter view: To set constraints on.
    func pinView(_ view: UIView, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        ])
    }
}
