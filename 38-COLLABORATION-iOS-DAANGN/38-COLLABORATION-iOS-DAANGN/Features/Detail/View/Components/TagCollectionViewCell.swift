//
//  TradeTag.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit

import Then
import SnapKit

final class TagCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "TagCollectionViewCell"
    
    private let tagLabel = PaddingLabel().then {
        $0.textInsets = UIEdgeInsets(top: 3, left: 4, bottom: 3, right: 4)
        $0.backgroundColor = .carrot100
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.setText("", style: .label3Medium, color: .carrot700)
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

private extension TagCollectionViewCell {
    
    func setUI() {
        addSubview(tagLabel)
    }
    
    func setLayout() {
        tagLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TagCollectionViewCell {
    func dataBind(tag: String) {
        tagLabel.setText(tag, style: .label3Medium, color: .carrot700)
    }
}
