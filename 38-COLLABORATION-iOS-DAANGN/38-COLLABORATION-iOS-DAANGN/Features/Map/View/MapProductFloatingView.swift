//
//  MapProductFloatingView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/16/26.
//


import UIKit

import SnapKit
import Then

final class MapProductFloatingView: UIView {
    
    // MARK: UI

    private let containerView = UIView().then {
        $0.backgroundColor = .gray00
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }

    private let contentView = UIView()

    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }

    private let addressTimeLabel = UILabel().then {
        $0.numberOfLines = 1
    }

    private let priceLabel = UILabel()

    private let heartImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }

    // MARK: 이닛
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: configure 셋업
    func configure(product: MapProduct) {
        productImageView.image = UIImage(named: product.imageName)

        titleLabel.attributedText = NSAttributedString.styled(
            product.title,
            style: .body2Bold,
            color: .gray900
        )

        addressTimeLabel.attributedText = NSAttributedString.styled(
            "\(product.address) · \(product.time)",
            style: .label1Regular,
            color: .gray500
        )

        priceLabel.attributedText = NSAttributedString.styled(
            product.price,
            style: .body1Bold,
            color: .gray900
        )

        heartImageView.image = UIImage(
            named: product.isLiked ? "heart_Fill" : "heart_line"
        )

        configureTags(product.tags)
    }
}

private extension MapProductFloatingView {

    func setupHierarchy() {
        addSubview(containerView)

        containerView.addSubview(productImageView)
        containerView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(addressTimeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(heartImageView)
        contentView.addSubview(tagStackView)
    }

    func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(347)
            $0.height.equalTo(140)
        }

        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(124)
        }

        contentView.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(199)
            $0.height.equalTo(108)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        addressTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(17)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(addressTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.height.equalTo(22)
        }

        heartImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }

        tagStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.height.equalTo(26)
        }
    }

    func configureTags(_ tags: [String]) {
        tagStackView.arrangedSubviews.forEach {
            tagStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        let visibleTags = Array(tags.prefix(2))

        visibleTags.forEach {
            tagStackView.addArrangedSubview(makeTagLabel(text: $0))
        }

        let remainCount = tags.count - visibleTags.count

        if remainCount > 0 {
            tagStackView.addArrangedSubview(makeTagLabel(text: "+\(remainCount)"))
        }
    }

    func makeTagLabel(text: String) -> UILabel {
        let label = MapPaddingLabel(
            topInset: 5,
            bottomInset: 5,
            leftInset: 8,
            rightInset: 8
        )

        label.backgroundColor = .gray100
        label.layer.cornerRadius = 13
        label.clipsToBounds = true

        label.attributedText = NSAttributedString.styled(
            text,
            style: .label1Regular,
            color: .gray700
        )

        return label
    }
}
