//
//  TradeTagCollectionView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/14/26.
//

import UIKit

import SnapKit
import Then

final class ProductStateTagListView: UIView {
    
    private let lineSpacing: CGFloat = 8
    private let interItemSpacing: CGFloat = 8
    private let cellHeight: CGFloat = 23
    private let inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private var tags: [String] = []
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .gray00
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        register()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductStateTagListView {
    
    func setUI() {
        addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func register() {
        collectionView.register(
            TagCollectionViewCell.self,
            forCellWithReuseIdentifier: TagCollectionViewCell.identifier
        )
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProductStateTagListView {
    
    func dataBind(tags: [String]) {
        self.tags = tags
        collectionView.reloadData()
    }
}

extension ProductStateTagListView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tags.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.identifier,
            for: indexPath
        ) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.dataBind(tag: tags[indexPath.item])
        return cell
    }
}

extension ProductStateTagListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let tag = tags[indexPath.item]
        let width = tag.size(withAttributes: [.font: FontStyle.label3Medium.font]).width + 8
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return inset
    }
}
