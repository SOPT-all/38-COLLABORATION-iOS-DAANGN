//
//  header.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/13/26.
//

import UIKit

import Then
import SnapKit

final class HeaderView: UIView {
    
    private let buttonContainerView = UIView()
    
    private let chevronButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_chevron_left"), for: .normal)
    }
    
    private let homeButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_house_line"), for: .normal)
    }
    
    private let shareButton = UIButton().then {
        $0.setImage(UIImage(named: "icon_download"), for: .normal)
    }
    
    private let dot3Button = UIButton().then {
        $0.setImage(UIImage(named: "icon_dot3_vertical_fill"), for: .normal)
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
}

private extension HeaderView {
    
    func setStyle() {
        backgroundColor = .clear
    }
    
    func setUI() {
        addSubview(buttonContainerView)
        buttonContainerView.addSubviews(chevronButton, homeButton, shareButton, dot3Button)
    }
    
    func setLayout() {
        buttonContainerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        chevronButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        homeButton.snp.makeConstraints {
            $0.leading.equalTo(chevronButton.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        dot3Button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalTo(dot3Button.snp.leading).inset(-6)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
    }
}
