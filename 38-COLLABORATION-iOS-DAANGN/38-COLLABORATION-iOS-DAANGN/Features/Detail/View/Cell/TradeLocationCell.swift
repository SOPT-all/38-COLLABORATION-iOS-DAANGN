//
//  TradeLocationCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class TradeLocationCell: UICollectionViewCell {
    static let identifier = "TradeLocationCell"
    
    private let tradeLocationTitle = UILabel().then {
        $0.setText("거래 희망 장소", style: .body1Medium)
    }
    
    private let tradeLocation = UILabel().then {
        $0.setText("", style: .body1Regular)
    }
    
    private let chevron = UIImageView().then {
        $0.image = UIImage(named: "icon_chevron_right")
    }
    
    private let map = UIImageView().then {
        $0.image = UIImage(named: "trade_location_map")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let viewCount = UILabel().then {
        $0.setText("", style: .label3Regular, color: .gray700)
    }
    
    private let report = UILabel().then {
        $0.setText("이 게시글 신고하기", style: .label3Regular, color: .gray700)
        $0.setUnderline(color: .gray700)
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

private extension TradeLocationCell {
    
    func setUI() {
        addSubviews(tradeLocationTitle, tradeLocation, chevron, map, viewCount, report)
    }
    
    func setLayout() {
        tradeLocationTitle.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(16)
        }
        tradeLocation.snp.makeConstraints {
            $0.centerY.equalTo(tradeLocationTitle)
            $0.leading.equalTo(tradeLocationTitle.snp.trailing).offset(8)
        }
        chevron.snp.makeConstraints{
            $0.centerY.equalTo(tradeLocationTitle)
            $0.leading.equalTo(tradeLocation.snp.trailing).offset(4)
            $0.size.equalTo(16)
        }
        map.snp.makeConstraints{
            $0.top.equalTo(tradeLocation.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(112)
        }
        viewCount.snp.makeConstraints{
            $0.top.equalTo(map.snp.bottom).inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        report.snp.makeConstraints{
            $0.top.equalTo(viewCount.snp.bottom).inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
extension TradeLocationCell {
    func dataBind(location: String, count: Int) {
        tradeLocation.setText(location, style: .body1Regular)
        viewCount.setText("조회 \(count)", style: .label3Regular, color: .gray700)
    }
}
