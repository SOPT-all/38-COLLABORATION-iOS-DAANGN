//
//  TagChip.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/14/26.
//

import UIKit

import Then
import SnapKit

final class TagLabel: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(label)
        label.setText("새상품", style: .label1Medium, color: .carrot700)
        self.backgroundColor = .carrot100
        self.layer.cornerRadius = 4
    }
    
    private func setLayout() {
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.center.equalToSuperview()
        }
    }
}
