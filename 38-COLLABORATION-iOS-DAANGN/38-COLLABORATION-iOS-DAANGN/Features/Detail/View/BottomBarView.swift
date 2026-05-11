//
//  BottomBarView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit
import Then
import SnapKit

final class BottomBarView: UIView {
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray100
    }
    
    private let heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .gray800
    }
    
    let chatButton = UIButton().then {
        $0.setTitle("채팅하기", style: .h5Bold, color: .gray00)
        $0.backgroundColor = .carrot600
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
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
        addSubview(dividerView)
        addSubview(heartButton)
        addSubview(chatButton)
    }
    
    private func setLayout() {
        dividerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        heartButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalTo(chatButton)
            $0.width.height.equalTo(24)
        }
        
        chatButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.height.equalTo(48)
            $0.leading.equalTo(heartButton.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
