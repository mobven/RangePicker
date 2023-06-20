//
//  RangePickerView.swift
//  RangePickerView
//
//  Created by Rashid Ramazanov on 8/15/22.
//  Copyright © 2022 Mobven. All rights reserved.
//

import UIKit

/// Methods for managing selections  in a range picker view.
public protocol RangePickerViewDelegate: AnyObject {
    func rangePickerView(_ rangePickerView: RangePickerView, didSelectRow row: Int)
    func rangePickerView(_ rangePickerView: RangePickerView, titleForRowAtIndex row: Int) -> String?
    func rangePickerView(_ rangePickerView: RangePickerView, numberOfIndicesAt row: Int) -> Int?
    func rangePickerView(_ rangePickerView: RangePickerView, headerTitleIndicesAt row: Int) -> String?
}

/// UI Component to display items in UIPickerView based on range selection.
public final class RangePickerView: UIView {
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var lblValue: UILabel!
    @IBOutlet var lblValueType: UILabel!
    @IBOutlet var valueView: UIView!

    var dataSource: DataSource = .init()

    /// Range of the values for the visible items. Default values is 10.
    public var visibilityRange: Int = 10 {
        didSet {
            dataSource.visibilityRange = visibilityRange
            pickerView.reloadAllComponents()
        }
    }

    /// A zero-indexed number identifying selection of the range picker view.
    public var selectedIndex: Int {
        pickerView.selectedRow(inComponent: .zero)
    }

    /// Selected row of the picker view. Default values is 0.
    public func selectRow(_ row: Int, animated: Bool) {
        pickerView.selectRow(row, inComponent: .zero, animated: animated)
        let selectedValue = delegate?.rangePickerView(self, titleForRowAtIndex: row) ?? ""
        if !selectedValue.isEmpty {
            pickerView.view(forRow: row, forComponent: .zero)?.isHidden = true
            lblValue.text = delegate?.rangePickerView(self, headerTitleIndicesAt: row)
        }
        pickerView.subviews[1].backgroundColor = .clear
    }

    /// Rotating picker view to horizontal directions if it's true. Default values is false.
    public var horizontalPicker: Bool = false {
        didSet {
            if horizontalPicker == true {
                rotate(angle: -90)
                valueView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                // lblValueType.text = "kg"
                setRange()
                dataSource.horizontalPicker = horizontalPicker
            } else {
                return
            }
        }
    }

    /// Rotating picker view to horizontal directions if it's true. Default values is false.
    public var valueType: String = "cm" {
        didSet {
            if valueType != "cm" {
                lblValueType.text = valueType
            } else {
                return
            }
        }
    }

    /// The object that acts as delegate of the range picker view.
    public weak var delegate: RangePickerViewDelegate?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        setupNib()
        pickerView.delegate = dataSource
        pickerView.dataSource = dataSource
        dataSource.delegate = self
        setRange()
        configurePickerView()
    }

    private func configurePickerView() {
        if #unavailable(iOS 14), pickerView.subviews.count > 2 {
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }
    }

    func setRange() {
        pickerView.reloadAllComponents()
        selectRow(.zero, animated: false)
    }
}

extension RangePickerView: RangePickerViewInternalDelegate {
    public func rangePickerView(titleForRowAt row: Int) -> String? {
        delegate?.rangePickerView(self, titleForRowAtIndex: row)
    }

    public func rangePickerView(didSelectRow row: Int) {
        delegate?.rangePickerView(self, didSelectRow: row)
        lblValue.text = delegate?.rangePickerView(self, headerTitleIndicesAt: row)
    }

    public func rangePickerView(numberOfIndexs index: Int) -> Int? {
        delegate?.rangePickerView(self, numberOfIndicesAt: index)
    }
}

extension RangePickerView {
    /**
       Rotate a view by specified degrees
       parameter angle: angle in degrees
     */

    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = transform.rotated(by: radians)
        transform = rotation
    }
}
