//
//  UILabel+.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/13/26.
//

import UIKit

extension UILabel {
    func setUnderline(color: UIColor) {
        guard let text = self.text else { return }

        let attributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString(string: text))

        attributedString.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: color
        ], range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
