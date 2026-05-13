//
//  UIColor.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/10/26.
//

import UIKit

extension UIColor {

    // MARK: Asset Loader

    private static func asset(_ name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            assertionFailure("컬러 에셋을 찾지 못함: \(name)")
            return .clear
        }
        return color
    }

    // MARK: Gray Scale

    static let gray00 = asset("gray-00")
    static let gray100 = asset("gray-100")
    static let gray200 = asset("gray-200")
    static let gray300 = asset("gray-300")
    static let gray400 = asset("gray-400")
    static let gray500 = asset("gray-500")
    static let gray600 = asset("gray-600")
    static let gray700 = asset("gray-700")
    static let gray800 = asset("gray-800")
    static let gray900 = asset("gray-900")
    static let gray1000 = asset("gray-1000")

    // MARK: Primary

    static let carrot100 = asset("carrot-100")
    static let carrot200 = asset("carrot-200")
    static let carrot300 = asset("carrot-300")
    static let carrot400 = asset("carrot-400")
    static let carrot500 = asset("carrot-500")
    static let carrot600 = asset("carrot-600")
    static let carrot700 = asset("carrot-700")
    static let carrot800 = asset("carrot-800")
    static let carrot900 = asset("carrot-900")
    static let carrot1000 = asset("carrot-1000")

    // MARK: Positive

    static let green200 = asset("green-200")
    static let green400 = asset("green-400")
    static let green600 = asset("green-600")
    static let green800 = asset("green-800")

    // MARK: Warning

    static let yellow200 = asset("yellow-200")
    static let yellow400 = asset("yellow-400")
    static let yellow600 = asset("yellow-600")
    static let yellow800 = asset("yellow-800")

    // MARK: Critical

    static let red200 = asset("red-200")
    static let red400 = asset("red-400")
    static let red600 = asset("red-600")
    static let red800 = asset("red-800")

    // MARK: Informative

    static let blue200 = asset("blue-200")
    static let blue400 = asset("blue-400")
    static let blue600 = asset("blue-600")
    static let blue800 = asset("blue-800")
}
