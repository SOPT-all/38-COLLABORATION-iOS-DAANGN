//
//  ProductDetailViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit

final class ProductDetailViewController: UIViewController {
    
    private var currentImageIndex = 0
    private weak var imageIndicatorView: ImageIndicatorView?
    private let productDetailData = ProductDetailData.dummy
    private let productDetailView = ProductDetailView()
    private let bottomBarView = BottomBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
}

private extension ProductDetailViewController {
    
    func setStyle() {
        view.backgroundColor = .gray00
        productDetailView.collectionView.dataSource = self
        productDetailView.onImageIndexChanged = { [weak self] index in
            self?.updateCurrentImageIndex(index)
        }
    }
    
    func setUI() {
        view.addSubviews(productDetailView, bottomBarView)
        bottomBarView.chatButton.addTarget(
            self,
            action: #selector(chatButtonDidTap),
            for: .touchUpInside
        )
    }
    
    func setLayout() {
        productDetailView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomBarView.snp.top)
        }
        
        bottomBarView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(68)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc
    private func chatButtonDidTap() {
        presentBottomSheetVC()
    }
    
    private func presentBottomSheetVC(){
        let bottomSheetViewController = BottomSheetViewController()
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetViewController, animated: false)
    }
    
    func updateCurrentImageIndex(_ index: Int) {
        guard currentImageIndex != index else { return }
        currentImageIndex = index
        imageIndicatorView?.dataBind(
            currentIndex: currentImageIndex,
            totalCount: productDetailData.imageURLs.count
        )
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductDetailSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let section = ProductDetailSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .imageCarousel:
            return productDetailData.imageURLs.count
        case .sellerProfile:
            return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = ProductDetailSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .imageCarousel:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCarouselCell.identifier,
                for: indexPath
            ) as? ImageCarouselCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(
                imageName: productDetailData.imageURLs[indexPath.item]
            )
            return cell
            
        case .sellerProfile:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SellerProfileCell.identifier,
                for: indexPath
            ) as? SellerProfileCell else {
                return UICollectionViewCell()
            }
            
            let seller = productDetailData.seller
            
            cell.dataBind(
                name: seller.name,
                address: seller.address,
                score: "\(seller.mannerTemperature)°C"
            )
            return cell
        }
    }

    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == ImageIndicatorView.elementKind,
              let indicatorView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ImageIndicatorView.identifier,
                for: indexPath
              ) as? ImageIndicatorView else {
            return UICollectionReusableView()
        }
        
        indicatorView.dataBind(
            currentIndex: currentImageIndex,
            totalCount: productDetailData.imageURLs.count
        )
        imageIndicatorView = indicatorView
        return indicatorView
    }
}
