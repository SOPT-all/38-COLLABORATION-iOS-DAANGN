//
//  FontStyle.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/10/26.
//

import UIKit

struct FontStyle {
    let font: UIFont
    let lineHeight: CGFloat
    
    init(
        size: CGFloat,
        weight: UIFont.Weight,
        lineHeightPercent: CGFloat = 130
    ) {
        self.font = .sfpro(size: size, weight: weight)
        self.lineHeight = size * (lineHeightPercent / 100)
    }
}

extension FontStyle {
    
    // MARK: - Head
    static let h1Bold = FontStyle(size: 26, weight: .bold)
    static let h2Bold = FontStyle(size: 24, weight: .bold)
    static let h3Bold = FontStyle(size: 22, weight: .bold)
    static let h4Bold = FontStyle(size: 20, weight: .bold)
    static let h4Medium = FontStyle(size: 20, weight: .medium)
    static let h5Bold = FontStyle(size: 18, weight: .bold)
    static let h5Medium = FontStyle(size: 18, weight: .medium)
    
    // MARK: - Body
    static let body1Bold = FontStyle(size: 16, weight: .bold)
    static let body1Medium = FontStyle(size: 16, weight: .medium)
    static let body1Regular = FontStyle(size: 16, weight: .regular)
    static let body2Bold = FontStyle(size: 14, weight: .bold)
    static let body2Medium = FontStyle(size: 14, weight: .medium)
    static let body2Regular = FontStyle(size: 14, weight: .regular)
    
    // MARK: - Label
    static let label1Medium = FontStyle(size: 11, weight: .medium)
    static let label1Regular = FontStyle(size: 11, weight: .regular)
    static let label2Medium = FontStyle(size: 12, weight: .medium)
    static let label2Regular = FontStyle(size: 12, weight: .regular)
    static let label3Medium = FontStyle(size: 13, weight: .medium)
    static let label3Regular = FontStyle(size: 13, weight: .regular)
}
