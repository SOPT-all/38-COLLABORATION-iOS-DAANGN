//
//  EmptyView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/21/26.
//

import UIKit

import SnapKit
import Then

final class EmptyView: UIView {

    var onResetButtonTapped: (() -> Void)?

    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let resetButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(mainLabel, subLabel, resetButton)
        mainLabel.setText("조명에 대한 검색 결과가 없어요.", style: .body1Regular, color: .gray1000)
        subLabel.setText("필터를 조정하거나 초기화 해보세요.", style: .body2Regular, color: .gray700)
        resetButton.setTitle("필터 초기화하기", style: .body2Medium, color: .gray1000)
        resetButton.do {
            $0.backgroundColor = .gray300
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(resetButtonDidTap), for: .touchUpInside)
        }
    }
    
    @objc
    private func resetButtonDidTap() {
        onResetButtonTapped?()
    }

    private func setLayout() {
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(230)
            $0.centerX.equalToSuperview()
        }
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        resetButton.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(38)
            $0.width.equalTo(113)
        }
    }
}
