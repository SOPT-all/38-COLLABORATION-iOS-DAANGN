//
//  FilterChip.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/12/26.
//

import UIKit

import Then
import SnapKit

final class FilterChip: UIView {

    private let filters = ["새상품", "미개봉", "나눔", "당일 거래", "문고리 거래", "택배 가능", "도보 5분", "급처", "반값할인"]

    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = false
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        filters.forEach { title in
            let button = makeChipButton(title: title)
            stackView.addArrangedSubview(button)
            let textWidth = title.size(withAttributes: [.font: FontStyle.label2Regular.font]).width
            button.snp.makeConstraints {
                $0.height.equalTo(30)
                $0.width.equalTo(ceil(textWidth) + 24)
            }
        }
    }

    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }
    }

    private func makeChipButton(title: String) -> ChipButton {
        let button = ChipButton()
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        button.setTitleColor(.gray1000, for: .normal)
        button.setTitleColor(.gray00, for: .selected)
        button.titleLabel?.font = FontStyle.label2Regular.font
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray300.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15

        button.onToggle = { [weak button] isSelected in
            button?.backgroundColor = isSelected ? .gray900 : .gray00
            button?.layer.borderColor = isSelected ? UIColor.gray900.cgColor : UIColor.gray300.cgColor
        }

        return button
    }
}
