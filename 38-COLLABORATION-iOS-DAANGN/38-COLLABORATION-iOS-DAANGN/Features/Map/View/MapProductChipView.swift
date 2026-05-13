//
//  MapProductChipView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/13/26.
//


import UIKit

import SnapKit
import Then

final class MapProductChipView: UIView {

    // MARK: UI

    private let containerView = UIView().then {
        $0.backgroundColor = .gray00
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = false

        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.14
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
    }

    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .gray100
    }

    private let priceLabel = UILabel()

    private let heartImageView = UIImageView().then {
        $0.image = UIImage(named: "heartIcon")
        $0.contentMode = .scaleAspectFit
    }

    // MARK: 이닛

    init(imageName: String, price: String, isLiked: Bool = false) {
        super.init(frame: .zero)

        setupHierarchy()
        setupLayout()
        configure(imageName: imageName, price: price, isLiked: isLiked)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MapProductChipView {

    func setupHierarchy() {
        addSubview(containerView)

        containerView.addSubview(productImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(heartImageView)
    }

    func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(32)
        }

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }

        heartImageView.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(12)
        }
    }

    func configure(imageName: String, price: String, isLiked: Bool) {
        productImageView.image = UIImage(named: imageName)

        priceLabel.attributedText = NSAttributedString.styled(
            price,
            style: .body2Bold,
            color: .gray900
        )

        heartImageView.isHidden = !isLiked
    }
}
