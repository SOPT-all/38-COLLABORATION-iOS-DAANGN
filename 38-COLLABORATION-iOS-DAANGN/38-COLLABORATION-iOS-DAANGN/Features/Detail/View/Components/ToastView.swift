//
//  ToastView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import Then
import SnapKit

final class ToastView: UIView {
    
    private let successMessage = UILabel().then {
        $0.setText("메세지가 전송되었어요", style: .label3Medium, color: .gray00)
    }
    
    private let goToChatLabel = UILabel().then {
        $0.setText("채팅창 가기", style: .label3Medium, color: .carrot600)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private let rightChevron = UIImageView().then {
        $0.image = .chevronRight?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .carrot600
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
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
        backgroundColor = .gray1000
        layer.cornerRadius = 8
    }
    
    private func setUI() {
        addSubviews(successMessage, goToChatLabel, rightChevron)
    }
    
    private func setLayout() {
        successMessage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(goToChatLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
        
        goToChatLabel.snp.makeConstraints {
            $0.trailing.equalTo(rightChevron.snp.leading).offset(-4.5)
            $0.centerY.equalToSuperview()
        }
        
        rightChevron.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(12)
            $0.centerY.equalToSuperview()
        }
    }
}
