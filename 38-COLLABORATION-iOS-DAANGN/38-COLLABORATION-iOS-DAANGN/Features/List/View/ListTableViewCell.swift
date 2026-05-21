//
//  ListTableViewCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/14/26.
//

import UIKit

import Then
import SnapKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"

    private let thumbnail = UIImageView()
    private let title = UILabel()
    private let tradeLocation = UILabel()
    private let minidot = UIView()
    private let lastBumpedAt = UILabel()
    private let price = UILabel()
    private let won = UILabel()
    private let tags = TagLabel()
    private let likeIcon = UIImageView()
    private let likeCount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: ProductListResponseDTO) {
        thumbnail.kf.setImage(with: URL(string: product.thumbnailUrl))
        title.setText(product.title, style: .body1Regular, color: .gray1000, lineBreakMode: .byTruncatingTail)
        tradeLocation.setText(product.tradeLocation, style: .label3Regular, color: .gray700)
        lastBumpedAt.setText(formattedElapsedTime(from: product.lastBumpedAt), style: .label3Regular, color: .gray700)
        price.setText(product.price.formatted(), style: .body1Bold, color: .gray1000)
        likeCount.setText("\(product.likeCount)", style: .label2Medium, color: .gray700)
        likeIcon.tintColor = .gray500
        tags.configure(tags: product.tags)
    }
}

private extension ListTableViewCell {
    
    private func setUI() {
        contentView.addSubviews(thumbnail, title, tradeLocation, minidot, lastBumpedAt, price, won, tags, likeIcon, likeCount)
    }
    
    private func setStyle() {
        selectionStyle = .none
        thumbnail.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        title.do {
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
        }
        tradeLocation.do {
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        lastBumpedAt.setContentCompressionResistancePriority(.required, for: .horizontal)
        minidot.do {
            $0.backgroundColor = .gray700
            $0.layer.cornerRadius = 1
        }
        won.setText("원", style: .body1Medium, color: .gray1000)
        likeIcon.do {
            $0.image = .heartFill?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .gray500
        }
    }
    
    private func formattedElapsedTime(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let date = formatter.date(from: dateString) else { return dateString }

        let elapsed = max(0, Int(Date().timeIntervalSince(date)))
        let minutes = elapsed / 60
        let hours = minutes / 60
        let days = hours / 24

        if minutes < 1 { return "끌올 방금 전" }
        if minutes < 60 { return "끌올 \(minutes)분 전" }
        if hours < 24 { return "끌올 \(hours)시간 전" }
        return "끌올 \(days)일 전"
    }

    private func setLayout() {
        thumbnail.snp.makeConstraints {
            $0.width.height.equalTo(114)
            $0.leading.equalToSuperview().inset(14)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalTo(thumbnail.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(18)
        }
        tradeLocation.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.leading.equalTo(title)
        }
        minidot.snp.makeConstraints {
            $0.leading.equalTo(tradeLocation.snp.trailing).offset(4)
            $0.width.height.equalTo(2)
            $0.centerY.equalTo(tradeLocation)
        }
        lastBumpedAt.snp.makeConstraints {
            $0.leading.equalTo(minidot.snp.trailing).offset(4)
            $0.centerY.equalTo(tradeLocation)
            $0.trailing.lessThanOrEqualTo(title.snp.trailing)
        }
        price.snp.makeConstraints {
            $0.leading.equalTo(title)
            $0.top.equalTo(tradeLocation.snp.bottom).offset(1)
        }
        won.snp.makeConstraints {
            $0.top.equalTo(price)
            $0.leading.equalTo(price.snp.trailing)
        }
        tags.snp.makeConstraints {
            $0.bottom.equalTo(thumbnail)
            $0.leading.equalTo(title)
        }
        likeCount.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(14)
        }
        likeIcon.snp.makeConstraints {
            $0.trailing.equalTo(likeCount.snp.leading).offset(-2)
            $0.width.height.equalTo(16)
            $0.centerY.equalTo(likeCount)
        }
    }
}
