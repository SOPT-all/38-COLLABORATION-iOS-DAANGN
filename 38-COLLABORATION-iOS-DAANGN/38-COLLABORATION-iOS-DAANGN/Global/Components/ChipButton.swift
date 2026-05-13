//
//  ChipButton.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/13/26.
//

import UIKit

final class ChipButton: UIButton {
    var onToggle: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bind()
    }

    private func bind() {
        addTarget(self, action: #selector(changeSelectedState), for: .touchUpInside)
    }

    @objc private func changeSelectedState() {
        isSelected = !isSelected
        onToggle?(isSelected)
    }
}
