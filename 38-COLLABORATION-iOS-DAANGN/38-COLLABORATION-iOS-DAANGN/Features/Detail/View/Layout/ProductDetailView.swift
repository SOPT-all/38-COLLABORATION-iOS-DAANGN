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
    case descript
    case tradeLocation
    case recommendItem
}

final class ProductDetailView: UIView {
    
    var onImageIndexChanged: ((Int) -> Void)?
    private let headerView = HeaderView()
    private let headerHeight: CGFloat = 105
    
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
        $0.register(
            DescriptionCell.self,
            forCellWithReuseIdentifier: DescriptionCell.identifier
        )
        $0.register(
            TradeLocationCell.self,
            forCellWithReuseIdentifier: TradeLocationCell.identifier
        )
        $0.register(
            RecommendItemCell.self,
            forCellWithReuseIdentifier: RecommendItemCell.identifier
        )
        $0.register(
            RecommendHeaderView.self,
            forSupplementaryViewOfKind: RecommendHeaderView.elementKind,
            withReuseIdentifier: RecommendHeaderView.identifier
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
            $0.height.equalTo(headerHeight)
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
            case .descript:
                return self.createDescriptSection()
            case .tradeLocation:
                return self.createTradeLocationSection()
            case .recommendItem:
                return self.createRecommendItemSection()
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(130)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createDescriptSection() ->
    NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createTradeLocationSection() ->
    NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(235)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    func createRecommendItemSection() ->
    NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(101), heightDimension: .absolute(173)), subitems: [item])
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(23)),
            elementKind: RecommendHeaderView.elementKind,
            alignment: .top
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension ProductDetailView {
    var currentHeaderHeight: CGFloat {
        return headerHeight
    }
    
    func updateHeaderStyle(isScrolled: Bool) {
        headerView.updateStyle(isScrolled: isScrolled)
    }
}
