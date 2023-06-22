//
//  RangePickerViewTests.swift
//  RangePickerTests
//
//  Created by Rashid Ramazanov on 21.06.2023.
//

import XCTest
@testable import RangePicker

final class RangePickerViewTests: XCTestCase {
    var sut: RangePickerView!

    override func setUp() {
        sut = .init()
    }

    func testAlignment() {
        setAlignment(.horizontal)
        // Test whether resetting does not changes orientation
        setAlignment(.horizontal)

        sut.alignment = .vertical
    }

    private func setAlignment(_ alignment: RangePickerView.Alignment) {
        sut.alignment = alignment
        XCTAssertEqual(sut.alignment, alignment)
        XCTAssertEqual(sut.mAlignment, alignment)
        XCTAssertEqual(sut.transform, .init(rotationAngle: alignment.angle))
        XCTAssertEqual(sut.valueView.transform, .init(rotationAngle: alignment.rotationAngle))
    }
}
