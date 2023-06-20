//
//  ViewController.swift
//  Sample
//
//  Created by Cem Eke on 20.06.2023.
//

import RangePicker
import UIKit

class ViewController: UIViewController {
    @IBOutlet var rangePickerView: RangePickerView!
    var values = Array(1...100)

    override func viewDidLoad() {
        super.viewDidLoad()
        rangePickerView.delegate = self
        rangePickerView.alignment = .horizontal
        rangePickerView.valueType = "kg"
    }

    @IBAction func changePickerAlignment(_ sender: UISwitch) {
        rangePickerView.alignment = sender.isOn ? .horizontal : .vertical
    }
}

extension ViewController: RangePickerViewDelegate {
    func rangePickerView(_ rangePickerView: RangePickerView, titleForRowAtIndex row: Int) -> String? {
        String(values[row])
    }

    func rangePickerView(_ rangePickerView: RangePickerView, didSelectRow row: Int) {}

    func rangePickerView(_ rangePickerView: RangePickerView, numberOfIndicesAt row: Int) -> Int? {
        values.count
    }

    func rangePickerView(_ rangePickerView: RangePickerView, headerTitleIndicesAt row: Int) -> String? {
        String(values[row])
    }
}
