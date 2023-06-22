//
//  RangePickerViewDataSource.swift
//  RangePickerView
//
//  Created by Rashid Ramazanov on 8/15/22.
//  Copyright © 2022 Mobven. All rights reserved.
//

import Foundation
import UIKit

protocol RangePickerViewInternalDelegate: AnyObject {
    func rangePickerView(didSelectRow row: Int)
    func rangePickerView(titleForRowAt row: Int) -> String?
    func rangePickerView(numberOfIndexs index: Int) -> Int?
}

extension RangePickerView {
    final class DataSource: NSObject {
        weak var delegate: RangePickerViewInternalDelegate?
        var visibilityRange: Int = 10
        var alignment: RangePickerView.Alignment = .vertical
        override init() {
            super.init()
        }
    }
}

extension RangePickerView.DataSource: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        delegate?.rangePickerView(numberOfIndexs: component) ?? 0
    }
}

extension RangePickerView.DataSource: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        16
    }

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        if row % visibilityRange == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 83, height: 10))
            let lineView = UIView(frame: CGRect(x: 0, y: 4, width: 48, height: 2))
            lineView.backgroundColor = .darkGray
            let valueLabel = UILabel(frame: CGRect(x: 56, y: 0, width: 27, height: 10))
            if row == pickerView.selectedRow(inComponent: .zero) {
                valueLabel.text = ""
            } else {
                valueLabel.text = delegate?.rangePickerView(titleForRowAt: row)
            }

            valueLabel.textColor = .darkGray
            valueLabel.font = .systemFont(ofSize: 14)
            if alignment == .horizontal {
                valueLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            }
            valueLabel.sizeToFit()
            view.tag = row
            view.addSubview(lineView)
            view.addSubview(valueLabel)
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 83, height: 10))
            let lineView = UIView(frame: CGRect(x: 0, y: 4, width: 36, height: 1))
            lineView.backgroundColor = .darkGray
            view.tag = row
            view.addSubview(lineView)
            return view
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        delegate?.rangePickerView(didSelectRow: row)
        pickerView.subviews[1].backgroundColor = .clear
    }
}
