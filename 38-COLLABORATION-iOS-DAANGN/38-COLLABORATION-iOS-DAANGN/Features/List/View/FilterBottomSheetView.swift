//
//  FilterBottomSheetView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/15/26.
//

import UIKit

import Then
import SnapKit

final class FilterBottomSheetView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        backgroundColor = .gray00
    }
}
