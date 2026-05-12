//
//  CategoryTabBar.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/12/26.
//

import UIKit

import Then
import SnapKit

// MARK: - CategoryTabCell

private final class CategoryTabCell: UICollectionViewCell {

    static let identifier = "CategoryTabCell"

    private let titleLabel = UILabel()

    private let indicatorView = UIView().then {
        $0.backgroundColor = .gray100
    }

    override var isSelected: Bool {
        didSet {
            indicatorView.backgroundColor = isSelected ? .gray900 : .gray100
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
        titleLabel.setText(title, style: .body2Regular)
    }

    private func setUI() {
        [titleLabel, indicatorView].forEach { contentView.addSubview($0) }
    }

    private func setLayout() {
        indicatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalTo(indicatorView.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
    }
}

// MARK: - CategoryTabBar

final class CategoryTabBar: UIView {

    private let tabs = ["전체", "중고거래", "업체소식", "동네생활", "동네업체", "스토리", "모임", "스토어", "중고차", "부동산"]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(CategoryTabCell.self, forCellWithReuseIdentifier: CategoryTabCell.identifier)
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

    override func layoutSubviews() {
        super.layoutSubviews()

        let defaultIndex = IndexPath(item: 1, section: 0)
        collectionView.selectItem(at: defaultIndex, animated: false, scrollPosition: [])
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

extension CategoryTabBar: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryTabCell.identifier,
            for: indexPath
        ) as? CategoryTabCell else { return UICollectionViewCell() }

        cell.configure(title: tabs[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryTabBar: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = tabs[indexPath.item]
        let textWidth = title.size(withAttributes: [.font: FontStyle.body2Regular.font]).width
        let width = textWidth + 28
        return CGSize(width: width, height: 42)
    }
}
