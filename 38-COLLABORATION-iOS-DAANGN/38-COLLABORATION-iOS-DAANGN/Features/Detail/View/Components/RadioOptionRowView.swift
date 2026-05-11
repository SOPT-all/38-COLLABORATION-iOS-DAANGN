//
//  RadioButton.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit
import Then
import SnapKit

final class RadioOptionRowView: UIView {
    
    private let radioImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .gray1000
    }
    
    init(title: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        
        setStyle(title: title, isSelected: isSelected)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RadioOptionRowView {
    
    func setStyle(title: String, isSelected: Bool) {
        radioImageView.image = UIImage(
            named: isSelected ? "radio_selected" : "radio_unselected"
        )
        optionLabel.setText(title, style: .h5Medium)
    }
    
    func setUI() {
        addSubviews(radioImageView, optionLabel)
    }
    
    func setLayout() {
        radioImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(radioImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}
