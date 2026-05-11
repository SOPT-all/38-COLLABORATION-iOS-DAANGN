//
//  BottomSheetView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit
import Then
import SnapKit

final class BottomSheetView: UIView {
    private let handleBarView = UIView().then {
        $0.backgroundColor = .gray400
        $0.layer.cornerRadius = 999
    }
    private let titleLabel = UILabel().then {
        $0.setText("간편문의", style: .h4Medium)
    }
    private let subtitleLabel = UILabel().then {
        $0.setText("친절한 인삿말과 함께 문의가 전송돼요", style: .label3Regular, color: .gray800)
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray100
    }
    private let optionStackView = UIStackView()
    private let sendButton = UIButton().then {
        $0.setTitle("전송하기", style: .h5Medium, color: .gray00)
        $0.backgroundColor = .carrot600
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        backgroundColor = .gray00
    }
    
    private func setUI() {
        addSubviews(handleBarView, titleLabel, subtitleLabel, dividerView, optionStackView, sendButton)
    }
    
    private func setLayout() {
        handleBarView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(4)
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(36)
            $0.leading.equalTo(20)
        }
        subtitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(20)
        }
        dividerView.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
        }
        sendButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(36)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}
