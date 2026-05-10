//
//  NSAttributedString+Extension.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/10/26.
//

import UIKit

extension NSAttributedString {
    
    static func styled(
        _ text: String,
        style: FontStyle,
        color: UIColor,
        alignment: NSTextAlignment = .natural
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = style.lineHeight
        paragraphStyle.maximumLineHeight = style.lineHeight
        paragraphStyle.alignment = alignment
        
        return NSAttributedString(
            string: text,
            attributes: [
                .font: style.font,
                .foregroundColor: color,
                .paragraphStyle: paragraphStyle
            ]
        )
    }
}
