//
//  PaddingLabel.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/16/26.
//


import UIKit

final class MapPaddingLabel: UILabel {

    // MARK: 프로퍼티
    private let topInset: CGFloat
    private let bottomInset: CGFloat
    private let leftInset: CGFloat
    private let rightInset: CGFloat

    
    // MARK: 이닛
    
    init(
        topInset: CGFloat,
        bottomInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat
    ) {
        self.topInset = topInset
        self.bottomInset = bottomInset
        self.leftInset = leftInset
        self.rightInset = rightInset

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: 오버라이드 모음
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(
            by: UIEdgeInsets(
                top: topInset,
                left: leftInset,
                bottom: bottomInset,
                right: rightInset
            )
        )

        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize

        return CGSize(
            width: size.width + leftInset + rightInset,
            height: size.height + topInset + bottomInset
        )
    }
}
