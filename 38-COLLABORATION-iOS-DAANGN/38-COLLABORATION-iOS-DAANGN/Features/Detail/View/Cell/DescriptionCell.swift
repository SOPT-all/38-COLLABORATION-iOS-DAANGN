//
//  DescriptionCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class DescriptionCell: UICollectionViewCell {
    static let identifier = "DescriptionCell"
    
    private let descript = UILabel().then {
        $0.numberOfLines = 0
        $0.setText("", style: .body1Regular)
        
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

private extension DescriptionCell {
    
    func setUI() {
        contentView.addSubview(descript)
    }
    
    func setLayout() {
        descript.snp.makeConstraints{
            $0.top.equalTo(contentView).inset(12)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView).inset(8)
        }
    }
}
extension DescriptionCell {
    func dataBind(content: String) {
        descript.setText(content, style: .body1Regular)
    }
}
