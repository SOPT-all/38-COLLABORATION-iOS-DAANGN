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

    private let handleAreaView = UIView()
    private let handleBarView = UIView().then {
        $0.backgroundColor = .gray400
        $0.layer.cornerRadius = 3
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        backgroundColor = .gray00
    }

    private func setUI() {
        addSubview(handleAreaView)
        handleAreaView.addSubview(handleBarView)
    }

    private func setLayout() {
        handleAreaView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(36)
        }
        handleBarView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(4)
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
    }
}

extension FilterBottomSheetView {
    func addHandleBarGesture(_ gesture: UIGestureRecognizer) {
        handleAreaView.addGestureRecognizer(gesture)
    }
}
