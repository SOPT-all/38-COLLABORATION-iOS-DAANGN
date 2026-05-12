//
//  Typography.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

extension UILabel {
    func setText(
        _ text: String,
        style: FontStyle,
        color: UIColor = .gray1000,
        alignment: NSTextAlignment = .natural
    ) {
        self.attributedText = .styled(
            text,
            style: style,
            color: color,
            alignment: alignment
        )
    }
}

extension UITextView {
    func setText(
        _ text: String,
        style: FontStyle,
        color: UIColor = .gray1000,
        alignment: NSTextAlignment = .natural
    ) {
        self.attributedText = .styled(
            text,
            style: style,
            color: color,
            alignment: alignment
        )
    }
}

extension UITextField {
    func setText(
        _ text: String,
        style: FontStyle,
        color: UIColor = .gray1000,
        alignment: NSTextAlignment = .natural
    ) {
        self.attributedText = .styled(
            text,
            style: style,
            color: color,
            alignment: alignment
        )
    }

    func setPlaceholder(
        _ text: String,
        style: FontStyle,
        color: UIColor = .gray400,
        alignment: NSTextAlignment = .natural
    ) {
        self.attributedPlaceholder = .styled(
            text,
            style: style,
            color: color,
            alignment: alignment
        )
    }
}

extension UIButton {
    func setTitle(
        _ title: String,
        style: FontStyle,
        color: UIColor = .gray1000,
        for state: UIControl.State = .normal,
        alignment: NSTextAlignment = .natural
    ) {
        self.setAttributedTitle(
            .styled(
                title,
                style: style,
                color: color,
                alignment: alignment
            ),
            for: state
        )
    }
}
