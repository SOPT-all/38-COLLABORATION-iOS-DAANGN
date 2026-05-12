//
//  FilterChip.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/12/26.
//

import UIKit

import Then
import SnapKit

// MARK: - FilterChipCell

private final class FilterChipCell: UICollectionViewCell {

    static let identifier = "FilterChipCell"
    static let chipHeight: CGFloat = 30

    private let titleLabel = UILabel()
    private var title: String = ""

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .gray900 : .white
            contentView.layer.borderColor = isSelected ? UIColor.gray900.cgColor : UIColor.gray300.cgColor
            titleLabel.setText(title, style: .label2Regular, color: isSelected ? .white : .gray1000)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        self.title = title
        titleLabel.setText(title, style: .label2Regular)
    }

    private func setUI() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray300.cgColor
        contentView.layer.cornerRadius = 999
        contentView.layer.masksToBounds = true

        contentView.addSubview(titleLabel)
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(7)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
    }
}

// MARK: - FilterChip

final class FilterChip: UIView {

    private let filters = ["새상품", "미개봉", "나눔", "당일 거래", "문고리 거래", "택배 가능", "도보 5분", "급처", "반값할인"]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 8
            $0.minimumLineSpacing = 8
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(FilterChipCell.self, forCellWithReuseIdentifier: FilterChipCell.identifier)
            $0.contentInsetAdjustmentBehavior = .never
        }
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        addSubview(collectionView)
    }

    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FilterChip: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilterChipCell.identifier,
            for: indexPath
        ) as? FilterChipCell else { return UICollectionViewCell() }

        cell.configure(title: filters[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FilterChip: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = filters[indexPath.item]
        let textWidth = title.size(withAttributes: [.font: FontStyle.label2Regular.font]).width
        let width = textWidth + 24
        return CGSize(width: width, height: FilterChipCell.chipHeight)
    }
}
