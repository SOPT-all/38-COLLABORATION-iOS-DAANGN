//
//  RecommendHeaderView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import Then
import SnapKit

final class RecommendHeaderView: UICollectionReusableView {
    static let identifier = "RecommendHeaderView"
    static let elementKind = "RecommendHeaderView"

    private let titleLabel = UILabel().then {
        $0.setText("메주님을 위한 새 상품 · 광고", style: .h5Medium)
    }
    private let information = UIImageView().then {
        $0.image = UIImage(named: "icon_information")
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

private extension RecommendHeaderView {
    func setUI() {
        addSubviews(titleLabel, information)
    }

    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        information.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(24)
        }
    }
}
