//
//  ImageIndicatorView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/13/26.
//

import UIKit

import SnapKit
import Then

final class ImageIndicatorView: UICollectionReusableView {
    static let identifier = "ImageIndicatorView"
    static let elementKind = "ImageIndicatorView"
    private static let horizontalPadding: CGFloat = 8
    
    private var indicatorLabelWidthConstraint: Constraint?
    
    private let indicatorLabel = UILabel().then {
        $0.backgroundColor = .gray1000.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImageIndicatorView {
    
    func setUI() {
        addSubview(indicatorLabel)
    }
    
    func setLayout() {
        indicatorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(22)
            indicatorLabelWidthConstraint = $0.width.equalTo(0).constraint
        }
    }
}

extension ImageIndicatorView {
    
    func dataBind(currentIndex: Int, totalCount: Int) {
        indicatorLabel.setText(
            "\(currentIndex + 1) / \(totalCount)",
            style: .label1Medium,
            color: .gray00,
            alignment: .center
        )
        
        indicatorLabel.sizeToFit()
        indicatorLabelWidthConstraint?.update(
            offset: indicatorLabel.intrinsicContentSize.width + Self.horizontalPadding * 2
        )
        setNeedsLayout()
        layoutIfNeeded()
    }
}
