//
//  HeaderView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/13/26.
//

import UIKit

import Then
import SnapKit

final class HeaderView: UIView {
    
    private var isScrolledStyleApplied = false
    private let gradientLayer = CAGradientLayer()
    private let buttonContainerView = UIView()
    
    private let chevronButton = UIButton().then {
        $0.setImage(.chevronLeft?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .gray00
    }
    
    private let homeButton = UIButton().then {
        $0.setImage(.houseLine?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .gray00
    }
    
    private let shareButton = UIButton().then {
        $0.setImage(.download?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .gray00
    }
    
    private let dot3Button = UIButton().then {
        $0.setImage(.dot3VerticalFill?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .gray00
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}

extension HeaderView {
    func updateStyle(isScrolled: Bool) {
        guard isScrolledStyleApplied != isScrolled else { return }
        isScrolledStyleApplied = isScrolled
        
        let iconColor: UIColor = isScrolled ? .gray1000 : .gray00
        let headerColor: UIColor = isScrolled ? .gray00 : .clear
        
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = headerColor
            self.gradientLayer.opacity = isScrolled ? 0 : 1
            self.chevronButton.tintColor = iconColor
            self.homeButton.tintColor = iconColor
            self.shareButton.tintColor = iconColor
            self.dot3Button.tintColor = iconColor
        }
    }
}

private extension HeaderView {
    
    func setStyle() {
        backgroundColor = .clear
        gradientLayer.colors = [
            UIColor.gray1000.withAlphaComponent(0.40).cgColor,
            UIColor.gray1000.withAlphaComponent(0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    func setUI() {
        layer.insertSublayer(gradientLayer, at: 0)
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
