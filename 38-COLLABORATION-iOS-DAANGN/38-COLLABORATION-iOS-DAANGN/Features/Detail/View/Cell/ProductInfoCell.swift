//
//  ProductInfoCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class ProductInfoCell: UICollectionViewCell {
    static let identifier = "productInformation"
    
    private let productTitle = UILabel().then {
        $0.setText("", style: .h3Bold)
    }
    
    private let productPrice = UILabel().then {
        $0.setText("", style: .h5Bold)
    }
    
    private let dangnPayIcon = UIImageView().then {
        $0.image = UIImage(named: "dangn_pay")
    }
    
    private let tradeLocation = UILabel().then {
        $0.setText("", style: .label3Regular, color: .gray700)
    }
    
    private let dot = UIView().then {
        $0.backgroundColor = .gray700
        $0.layer.cornerRadius = 1
    }
    
    private let bumpTime = UILabel().then {
        $0.setText("", style: .label3Regular, color: .gray700)
        
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

private extension ProductInfoCell {
    
    func setUI() {
        contentView.addSubviews(productTitle, productPrice, dangnPayIcon, tradeLocation, dot, bumpTime)
    }
    
    func setLayout() {
        productTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        productPrice.snp.makeConstraints {
            $0.top.equalTo(productTitle.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
        }
        dangnPayIcon.snp.makeConstraints {
            $0.centerY.equalTo(productPrice)
            $0.leading.equalTo(productPrice.snp.trailing).offset(10)
        }
        tradeLocation.snp.makeConstraints {
            $0.top.equalTo(productPrice.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        dot.snp.makeConstraints{
            $0.size.equalTo(2)
            $0.leading.equalTo(tradeLocation.snp.trailing).offset(3)
            $0.centerY.equalTo(tradeLocation)
        }
        bumpTime.snp.makeConstraints {
            $0.top.equalTo(productPrice.snp.bottom).offset(8)
            $0.leading.equalTo(dot.snp.leading).offset(3)
        }
    }
}

extension ProductInfoCell {
    
    func dataBind(
        name: String,
        price: Int,
        location: String,
        time: String
    ) {
        productTitle.setText(name, style: .h3Bold)
        productPrice.setText("\(price.formatted())원", style: .h5Bold)
        tradeLocation.setText(location, style: .label3Regular, color: .gray700)
        bumpTime.setText(time, style: .label3Regular, color: .gray700)
    }
}
