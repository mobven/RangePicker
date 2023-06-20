//
//  ViewController.swift
//  Sample
//
//  Created by Cem Eke on 20.06.2023.
//

import RangePicker
import UIKit

class ViewController: UIViewController {
    @IBOutlet var rangePicker: RangePicker!
    var values: [Int] = [1, 2, 3, 4, 5]

    override func viewDidLoad() {
        super.viewDidLoad()
        rangePicker.delegate = self
        rangePicker.horizontalPicker = true
        rangePicker.valueType = "kg"
    }

    func rangePickerView(_ rangePickerView: RangePickerView, titleForRowAtIndex row: Int) -> String? {
        values[row].value
    }

    func rangePickerView(_ rangePickerView: RangePickerView, didSelectRow row: Int) {}

    func rangePickerView(_ rangePickerView: RangePickerView, numberOfIndicesAt row: Int) -> Int? {
        values.count
    }

    func rangePickerView(_ rangePickerView: RangePickerView, headerTitleIndicesAt row: Int) -> String? {
        values[row].value
    }
}
