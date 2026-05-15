//
//  SelectedMapProductChipView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/15/26.
//

import UIKit

import SnapKit
import Then

final class SelectedMapProductChipView: UIView {

    // MARK: - UI

    private let containerView = UIView().then {
        $0.backgroundColor = .gray1000
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .gray100
    }

    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .leading
    }

    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.clipsToBounds = false
    }

    private let priceLabel = UILabel().then {
        $0.numberOfLines = 1
    }

    // MARK: - 이닛

    init(imageName: String, title: String, price: String) {
        super.init(frame: .zero)

        setupHierarchy()
        setupLayout()
        configure(imageName: imageName, title: title, price: price)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectedMapProductChipView {

    func setupHierarchy() {
        addSubview(containerView)

        containerView.addSubview(productImageView)
        containerView.addSubview(textStackView)

        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(priceLabel)
    }

    func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(124)
            $0.height.equalTo(40)
        }

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        textStackView.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalTo(85)
            $0.height.equalTo(14)
        }

        priceLabel.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(18)
        }
    }

    func configure(imageName: String, title: String, price: String) {
        productImageView.image = UIImage(named: imageName)

        titleLabel.attributedText = NSAttributedString.styled(
            title,
            style: .label1Regular,
            color: .gray00
        )

        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail

        priceLabel.attributedText = NSAttributedString.styled(
            price,
            style: .body2Bold,
            color: .gray00
        )
    }
}
