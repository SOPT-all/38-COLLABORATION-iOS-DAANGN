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
    private var isHeaderScrolledStyleApplied = false
    private weak var imageIndicatorView: ImageIndicatorView?
    private let productId: Int
    private var productDetailData: ProductDetailResponseDTO?
    private let productDetailView = ProductDetailView()
    private var adProductList: [AdProductListResponseDTO] = []
    private let toastView = ToastView()
    private let bottomBarView = BottomBarView()
    private var toastDismissWorkItem: DispatchWorkItem?
    
    init(productId: Int = 6) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        fetchProductDetail(productId: productId)
        fetchAdProductList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isHeaderScrolledStyleApplied ? .darkContent : .lightContent
    }
}

private extension ProductDetailViewController {
    
    func setStyle() {
        view.backgroundColor = .gray00
        toastView.isHidden = true
        productDetailView.collectionView.dataSource = self
        productDetailView.collectionView.delegate = self
        productDetailView.onImageIndexChanged = { [weak self] index in
            self?.updateCurrentImageIndex(index)
        }
        productDetailView.onChevronButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func setUI() {
        view.addSubviews(productDetailView, toastView, bottomBarView)
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-68)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        toastView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(bottomBarView.snp.top).offset(-16)
            $0.height.equalTo(49)
        }
    }
    
    @objc
    private func chatButtonDidTap() {
        presentBottomSheetVC()
    }
    
    private func presentBottomSheetVC(){
        let bottomSheetViewController = BottomSheetViewController()
        bottomSheetViewController.modalPresentationStyle = .overFullScreen
        bottomSheetViewController.onSendButtonTapped = { [weak self] in
            self?.showToast()
        }
        self.present(bottomSheetViewController, animated: false)
    }
    
    private func showToast() {
        toastDismissWorkItem?.cancel()
        view.layoutIfNeeded()
        
        toastView.isHidden = false
        toastView.transform = CGAffineTransform(
            translationX: 0,
            y: bottomBarView.frame.height + 56
        )
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.2,
            options: [.curveEaseOut]
        ) {
            self.toastView.transform = .identity
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [.curveEaseIn]
            ) {
                self.toastView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.bottomBarView.frame.height + 56
                )
            } completion: { _ in
                self.toastView.isHidden = true
            }
        }
        
        toastDismissWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: workItem)
    }
    
    func updateCurrentImageIndex(_ index: Int) {
        guard currentImageIndex != index else { return }
        currentImageIndex = index
        imageIndicatorView?.dataBind(
            currentIndex: currentImageIndex,
            totalCount: productDetailData?.imageUrls.count ?? 0
        )
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
            return productDetailData?.imageUrls.count ?? 0
        case .sellerProfile:
            return productDetailData == nil ? 0 : 1
        case .productInformation:
            return productDetailData == nil ? 0 : 1
        case .descript:
            return productDetailData == nil ? 0 : 1
        case .tradeLocation:
            return productDetailData == nil ? 0 : 1
        case .recommendItem:
            return adProductList.count
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
            guard let productDetailData else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCarouselCell.identifier,
                for: indexPath
            ) as? ImageCarouselCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(
                imageURL: productDetailData.imageUrls[indexPath.item]
            )
            return cell
            
        case .sellerProfile:
            guard let productDetailData else {
                return UICollectionViewCell()
            }
            
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
            
        case .productInformation:
            guard let productDetailData else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductInfoCell.identifier,
                for: indexPath
            ) as? ProductInfoCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(
                name: productDetailData.title,
                price: productDetailData.price,
                location: productDetailData.tradeLocation,
                time: productDetailData.lastBumpedAt,
                tags: productDetailData.tags
            )
            return cell
            
        case .descript:
            guard let productDetailData else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DescriptionCell.identifier,
                for: indexPath
            ) as? DescriptionCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(
                content: productDetailData.content
            )
            return cell
            
        case .tradeLocation:
            guard let productDetailData else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TradeLocationCell.identifier,
                for: indexPath
            ) as? TradeLocationCell else {
                return UICollectionViewCell()
            }
            
            cell.dataBind(
                location: productDetailData.tradeLocation,
                count: productDetailData.viewCount
            )
            return cell
            
        case .recommendItem:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendItemCell.identifier,
                for: indexPath
            ) as? RecommendItemCell else {
                return UICollectionViewCell()
            }
            
            let product = adProductList[indexPath.item]
            
            cell.dataBind(
                imgURL: product.thumbnailUrl,
                title: product.title,
                price: product.price,
                seller: product.seller
            )
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case ImageIndicatorView.elementKind:
            guard let indicatorView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ImageIndicatorView.identifier,
                for: indexPath
            ) as? ImageIndicatorView else {
                return UICollectionReusableView()
            }
            
            indicatorView.dataBind(
                currentIndex: currentImageIndex,
                totalCount: productDetailData?.imageUrls.count ?? 0
            )
            imageIndicatorView = indicatorView
            return indicatorView
            
        case RecommendHeaderView.elementKind:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RecommendHeaderView.identifier,
                for: indexPath
            ) as? RecommendHeaderView else {
                return UICollectionReusableView()
            }
            return headerView
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension ProductDetailViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageCarouselBottom = productDetailView.collectionView.bounds.width
        let headerTouchThreshold = imageCarouselBottom - productDetailView.currentHeaderHeight
        let shouldApplyScrolledStyle = scrollView.contentOffset.y >= headerTouchThreshold
        
        guard isHeaderScrolledStyleApplied != shouldApplyScrolledStyle else { return }
        isHeaderScrolledStyleApplied = shouldApplyScrolledStyle
        
        productDetailView.updateHeaderStyle(isScrolled: shouldApplyScrolledStyle)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func fetchProductDetail(productId: Int) {
        Task {
            do {
                let productDetail: ProductDetailResponseDTO = try await BaseService.shared.request(
                    endPoint: .productDetail(productId: productId)
                )

                await MainActor.run {
                    self.productDetailData = productDetail
                    self.productDetailView.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchAdProductList() {
        Task {
            do {
                let fetchedAdProductList: [AdProductListResponseDTO] = try await BaseService.shared.request(
                    endPoint: .adProductList
                )

                await MainActor.run {
                    self.adProductList = fetchedAdProductList
                    self.productDetailView.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}
