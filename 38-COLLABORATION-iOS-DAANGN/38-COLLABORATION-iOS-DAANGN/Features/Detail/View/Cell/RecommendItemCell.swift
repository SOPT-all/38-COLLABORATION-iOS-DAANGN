//
//  RecommendItemCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class RecommendItemCell: UICollectionViewCell {
    static let identifier = "RecommendItemCell"
         
    private let productImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray100.cgColor
    }
    private let productTitle = UILabel().then {
        $0.numberOfLines = 2
        $0.lineBreakMode = .byTruncatingTail
        $0.setText("", style: .label3Regular)
    }
    private let productPrice = UILabel().then {
        $0.setText("", style: .label3Medium)
    }
    private let productSeller = UILabel().then {
        $0.setText("", style: .label1Regular)
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

private extension RecommendItemCell {
    
    func setUI() {
        addSubviews(productImage, productTitle, productPrice, productSeller)
    }
    
    func setLayout() {
        productImage.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        productTitle.snp.makeConstraints{
            $0.top.equalTo(productImage.snp.bottom).offset(7)
            $0.horizontalEdges.equalToSuperview()
        }
        productPrice.snp.makeConstraints{
            $0.top.equalTo(productTitle.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        productSeller.snp.makeConstraints{
            $0.top.equalTo(productPrice.snp.bottom).offset(2)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
extension RecommendItemCell {
    func dataBind(imgURL: String, title: String, price: Int, seller: String) {
        productImage.kf.setImage(with: URL(string: imgURL))
        productTitle.setText(title, style: .label3Regular, lineBreakMode: .byTruncatingTail)
        productPrice.setText("\(price.formatted())원", style: .label3Medium)
        productSeller.setText(seller, style: .label1Regular, color: .gray700)
    }
}
