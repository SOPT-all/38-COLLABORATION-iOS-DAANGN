//
//  ListTableViewCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/14/26.
//

import UIKit

import Then
import SnapKit

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
}

private extension ListTableViewCell {
    
    private func setUI() {
        contentView.addSubviews(thumbnail, title, tradeLocation, minidot, lastBumpedAt, price, won, tags, likeIcon, likeCount)
    }
    
    private func setStyle() {
        selectionStyle = .none
        thumbnail.do {
            $0.image = UIImage(named: "lamp-ex")
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        title.setText("무드등 스탠드 조명", style: .body1Regular, color: .gray1000)
        tradeLocation.setText("수원 매산로1가", style: .label3Regular, color: .gray700)
        minidot.do {
            $0.backgroundColor = .gray700
            $0.layer.cornerRadius = 1
        }
        lastBumpedAt.setText("끌올 16분 전", style: .label3Regular, color: .gray700)
        price.setText("17,000", style: .body1Bold, color: .gray1000)
        won.setText("원", style: .body1Medium, color: .gray1000)
        likeIcon.do {
            $0.image = .heartFill?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .gray500
        }
        likeCount.setText("3", style: .label2Medium, color: .gray700)
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
