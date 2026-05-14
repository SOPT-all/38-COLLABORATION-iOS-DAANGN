//
//  SellerProfileCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class SellerProfileCell: UICollectionViewCell {
    static let identifier = "SellerProfileCell"
    
    private let profileImage = UIView().then {
        $0.backgroundColor = .gray300
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let sellerName = UILabel().then {
        $0.setText("", style: .body1Medium)
    }
    
    private let sellerAddress = UILabel().then {
        $0.setText("", style: .label3Regular, color: .gray100)
    }
    
    private let trustScore = UILabel().then {
        $0.setText("", style: .body1Bold, color: .carrot600)
    }
    
    private let trustScoreIcon = UIImageView().then {
        $0.image = UIImage(named: "icon_face_smile_circle_line")
    }
    
    private let trustScoreLabel = UILabel().then {
        $0.setText("매너온도", style: .label1Regular, color: .gray700)
        $0.setUnderline(color: .gray700)
    }
    
    private let divider = UIView().then {
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
}

private extension SellerProfileCell {
    
    func setUI() {
        contentView.addSubviews(profileImage, sellerName, sellerAddress, trustScoreIcon, trustScore, trustScoreLabel, divider)
    }
    
    func setLayout() {
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(15)
            $0.size.equalTo(40)
        }
        sellerName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
        }
        sellerAddress.snp.makeConstraints {
            $0.top.equalTo(sellerName.snp.bottom)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
        }
        trustScoreIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.trailing.equalToSuperview().inset(14)
        }
        trustScore.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27.5)
            $0.trailing.equalTo(trustScoreIcon.snp.leading).offset(-3)
        }
        trustScoreLabel.snp.makeConstraints {
            $0.top.equalTo(trustScoreIcon.snp.bottom)
            $0.trailing.equalToSuperview().inset(14)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
}

extension SellerProfileCell {
    
    func dataBind(
        name: String,
        address: String,
        score: String
    ) {
        sellerName.setText(name, style: .body1Medium)
        sellerAddress.setText(address, style: .label3Regular, color: .gray700)
        trustScore.setText(score, style: .body1Bold, color: .carrot600)
    }
}
