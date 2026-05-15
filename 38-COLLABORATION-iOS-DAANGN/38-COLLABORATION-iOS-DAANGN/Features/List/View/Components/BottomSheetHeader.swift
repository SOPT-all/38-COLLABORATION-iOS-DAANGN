//
//  BottomSheetHeader.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/15/26.
//

import UIKit

import Then
import SnapKit

final class BottomSheetHeader: UIView {
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let seperator = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(titleLabel, closeButton, seperator)
        titleLabel.setText("카테고리", style: .h4Medium, color: .gray1000)
        closeButton.setImage(.close?.withTintColor(.gray700), for: .normal)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(26)
            $0.verticalEdges.equalToSuperview().inset(14)
        }
        seperator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension BottomSheetHeader {
    func addCloseTarget(_ target: Any?, action: Selector) {
        closeButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
