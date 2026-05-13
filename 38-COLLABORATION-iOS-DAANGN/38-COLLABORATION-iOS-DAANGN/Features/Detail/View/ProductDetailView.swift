//
//  ProductDetailView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/13/26.
//

import UIKit

import SnapKit
import Then

enum ProductDetailSection: Int, CaseIterable {
    case imageCarousel
    case sellerProfile
    case productInformation
}

final class ProductDetailView: UIView {
    
    var onImageIndexChanged: ((Int) -> Void)?
    private let headerView = HeaderView()
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    ).then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .gray00
        $0.register(
            ImageCarouselCell.self,
            forCellWithReuseIdentifier: ImageCarouselCell.identifier
        )
        $0.register(
            ImageIndicatorView.self,
            forSupplementaryViewOfKind: ImageIndicatorView.elementKind,
            withReuseIdentifier: ImageIndicatorView.identifier
        )
        $0.register(SellerProfileCell.self, forCellWithReuseIdentifier: SellerProfileCell.identifier)
        $0.register(
            ProductInfoCell.self,
            forCellWithReuseIdentifier: ProductInfoCell.identifier
        )
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductDetailView {
    
    func setUI() {
        addSubviews(collectionView, headerView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(105)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = ProductDetailSection(rawValue: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .imageCarousel:
                return self.createImageCarouselSection()
            case .sellerProfile:
                return self.createSellerProfileSection()
            case .productInformation:
                return self.createProductInformationSection()
            }
        }
    }
    
    func createImageCarouselSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [createImageIndicatorItem()]
        section.visibleItemsInvalidationHandler = { [weak self] _, contentOffset, environment in
            guard environment.container.effectiveContentSize.width > 0 else { return }
            let page = Int(round(contentOffset.x / environment.container.effectiveContentSize.width))
            self?.onImageIndexChanged?(page)
        }
        return section
    }
    
    func createImageIndicatorItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let indicatorSize = NSCollectionLayoutSize(
            widthDimension: .estimated(72),
            heightDimension: .absolute(22)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: indicatorSize,
            elementKind: ImageIndicatorView.elementKind,
            alignment: .bottomTrailing,
            absoluteOffset: CGPoint(x: 0, y: -35)
        )
    }
    
    func createSellerProfileSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createProductInformationSection() ->
    NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(95)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
