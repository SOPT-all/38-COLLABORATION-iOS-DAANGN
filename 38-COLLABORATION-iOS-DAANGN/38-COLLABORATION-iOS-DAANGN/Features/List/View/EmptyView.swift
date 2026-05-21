//
//  EmptyView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/21/26.
//

import UIKit

import SnapKit

final class EmptyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray00
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
