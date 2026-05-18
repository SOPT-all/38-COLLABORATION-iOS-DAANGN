//
//  TagLabel.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/14/26.
//

import UIKit

import Then
import SnapKit

final class TagLabel: UIView {

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(tags: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let maxVisible = 2
        let visibleTags = Array(tags.prefix(maxVisible))
        let remaining  = tags.count - maxVisible

        visibleTags.forEach { stackView.addArrangedSubview(makeBadge(text: $0)) }

        if remaining > 0 {
            stackView.addArrangedSubview(makeBadge(text: "+\(remaining)"))
        }
    }

    // MARK: - Private

    private func makeBadge(text: String) -> UIView {
        let label = UILabel()
        label.setText(text, style: .label1Medium, color: .carrot700)

        let badge = UIView()
        badge.backgroundColor = .carrot100
        badge.layer.cornerRadius = 4
        badge.addSubview(label)
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.verticalEdges.equalToSuperview().inset(3)
        }
        return badge
    }
}
