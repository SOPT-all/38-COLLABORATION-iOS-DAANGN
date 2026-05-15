//
//  SearchBarHeader.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/12/26.
//

import UIKit

import Then
import SnapKit

protocol SearchBarHeaderDelegate: AnyObject {
    func filterButtonDidTap()
}

final class SearchBarHeader: UIView {
    
    weak var delegate: SearchBarHeaderDelegate?
    
    private lazy var backButton = UIButton().then {
        $0.setImage(.chevronLeft, for: .normal)
    }
    
    private let searchInput = UITextField().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.backgroundColor = .gray200
        $0.layer.cornerRadius = 8
        $0.addLeftPadding(12)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setImage(.xmarkCircleFill, for: .normal)
    }
    
    private lazy var filterButton = UIButton().then {
        $0.setImage(.filter, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [backButton, searchInput, filterButton].forEach { self.addSubview($0) }

        searchInput.addRightButton(closeButton)
        searchInput.setText("조명", style: .body1Regular)
    }
    
    private func setAddTarget() {
        closeButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        filterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        searchInput.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.trailing.equalTo(filterButton.snp.leading).offset(-8)
            $0.height.equalTo(40)
        }
    }

    @objc
    private func clearText() {
        searchInput.text = ""
        searchInput.resignFirstResponder()
        resignFirstResponder()
    }
    
    @objc
    private func filterButtonDidTap() {
        delegate?.filterButtonDidTap()
    }
}
