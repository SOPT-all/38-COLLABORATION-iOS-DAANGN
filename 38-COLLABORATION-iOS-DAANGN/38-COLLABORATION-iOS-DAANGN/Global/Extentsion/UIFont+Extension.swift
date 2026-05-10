//
//  UIFont+Extension.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/10/26.
//


import UIKit

extension UIFont {
    
    static func sfpro(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SFPRO"
        let weightString: String
        
        switch weight {
        case .bold:
            weightString = "Bold"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        default:
            weightString = "Regular"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size)
        ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}
