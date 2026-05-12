//
//  FilterSortBar.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/12/26.
//

import UIKit

import Then
import SnapKit

final class FilterSortBar: UIView {
    private let onSaleCheckButton = UIButton().then {
        $0.setImage(.rectangle, for: .normal)
    }
    private let onSaleLabel = UILabel()
    
    private let isNearCheckButton = UIButton().then {
        $0.setImage(.rectangle, for: .normal)
    }
    
    private let isNearLabel = UILabel()
    
    private let sortLabel = UILabel()
    
    private let dropdownButton = UIButton().then {
        $0.setImage(.chevrondown, for: .normal)
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
        [onSaleCheckButton, onSaleLabel, isNearCheckButton, isNearLabel, sortLabel, dropdownButton].forEach { self.addSubview($0) }
        onSaleLabel.setText("판매중만 보기", style: .label3Regular)
        isNearLabel.setText("동네매물만 보기", style: .label3Regular)
        sortLabel.setText("추천순", style: .label3Regular)
    }

    private func setLayout() {
        onSaleCheckButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        onSaleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(onSaleCheckButton.snp.trailing).offset(6)
        }
        isNearCheckButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(onSaleLabel.snp.trailing).offset(16)
        }
        isNearLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(isNearCheckButton.snp.trailing).offset(6)
        }
        dropdownButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-26)
        }
        sortLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(dropdownButton.snp.leading).offset(-4)
        }
    }
}

