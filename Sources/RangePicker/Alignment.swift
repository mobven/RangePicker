//
//  Alignment.swift
//  RangePicker
//
//  Created by Rashid Ramazanov on 21.06.2023.
//

import Foundation

public extension RangePickerView {
    enum Alignment {
        case horizontal, vertical
        var angle: CGFloat {
            switch self {
            case .horizontal: return -90 / 180.0 * CGFloat.pi
            case .vertical: return 90 / 180.0 * CGFloat.pi
            }
        }

        var rotationAngle: CGFloat {
            switch self {
            case .horizontal: return CGFloat.pi / 2
            case .vertical: return CGFloat.pi * 2
            }
        }
    }
}
