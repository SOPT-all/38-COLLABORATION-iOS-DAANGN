//
//  BannerCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/15/26.
//

import UIKit

import Then
import SnapKit

class BannerCell: UITableViewCell {
    
    static let identifier: String = "BannerCell"
    
    private let mapDaangn = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let detailButton = UIButton()
    
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

private extension BannerCell {
    
    private func setUI() {
        contentView.addSubviews(mapDaangn, titleLabel, subtitleLabel, detailButton)
    }
    
    private func setStyle() {
        contentView.backgroundColor = .gray100
        mapDaangn.do {
            $0.image = UIImage(named: "map_daangn")
            $0.contentMode = .scaleAspectFill
        }
        titleLabel.setText("내 근처 매물을 지도에서 한 눈에", style: .body1Medium, color: .gray1000)
        subtitleLabel.setText("지도 확인하기", style: .label3Regular, color: .gray800)
        detailButton.setImage(.chevronRight?.withTintColor(.gray1000), for: .normal)
    }
    
    private func setLayout() {
        mapDaangn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(58)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mapDaangn.snp.trailing).offset(7)
            $0.top.equalTo(mapDaangn.snp.top).offset(8.5)
        }
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        detailButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(16)
        }
    }
}
