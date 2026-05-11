//
//  RadioButton.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit
import Then
import SnapKit

final class RadioOptionRowView: UIControl {
    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    private let radioImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let optionLabel = UILabel().then {
        $0.setText("", style: .body1Regular)
    }
    
    init(title: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        
        self.isSelected = isSelected
        setStyle(title: title)
        setUI()
        setLayout()
        updateStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RadioOptionRowView {
    
    func setStyle(title: String) {
        optionLabel.setText(title, style: .body1Regular)
    }
    
    func setUI() {
        addSubviews(radioImageView, optionLabel)
    }
    
    func setLayout() {
        radioImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(radioImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    func updateStyle() {
        radioImageView.image = UIImage(
            named: isSelected ? "radio_button_fill" : "radio_button"
        )
    }
}
