//
//  PaddingLabel.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/14/26.
//

import UIKit

final class PaddingLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 3, left: 4, bottom: 3, right: 4)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }
}
