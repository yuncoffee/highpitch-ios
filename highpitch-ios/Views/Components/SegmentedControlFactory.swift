//
//  SegmentedControlFactory.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/6/24.
//

import Foundation
import UIKit

struct SegmentedControlFactory {
    static func build(segments: [String]) -> UISegmentedControl {
        let segment = UISegmentedControl()
        let image = UIImage()
        segment.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segment.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segment.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        segment.setDividerImage(image, 
                                forLeftSegmentState: .selected,
                                rightSegmentState: .normal,
                                barMetrics: .default)

        segment.setTitleTextAttributes([
            .foregroundColor: UIColor.TextScale.text300,
            .font: UIFont.pretendard(.headline, weight: .semiBold)
        ], for: .normal)
        segment.setTitleTextAttributes([
            .foregroundColor: UIColor.TextScale.text900,
            .font: UIFont.pretendard(.headline, weight: .bold)
        ], for: .selected)
                
        segments.enumerated().forEach { index, title in
            segment.insertSegment(withTitle: title, at: index, animated: true)
        }
        segment.selectedSegmentIndex = 0
        
        return segment
    }
}
