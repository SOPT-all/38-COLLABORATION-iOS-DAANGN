//
//  UIFont+Extension.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/10/26.
//


import UIKit

extension UIFont {
    
    static func sfpro(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName: String
        
        switch weight {
        case .bold:
            fontName = "SF-Pro-Text-Bold"
        case .medium:
            fontName = "SF-Pro-Text-Medium"
        case .regular:
            fontName = "SF-Pro-Text-Regular"
        default:
            fontName = "SF-Pro-Text-Regular"
        }
        
        return UIFont(name: fontName, size: size)
        ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}
