//
//  ListViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/11/26.
//

import UIKit

import Then
import SnapKit

class ListViewController: UIViewController {

    private let listView = ListView()
    private let mapButton = ViewToggleButton(imageName: "map", title: "지도 보기")
    private var products: [ProductListResponseDTO] = []
    private var filterState: FilterState = FilterState()

    private var filteredProducts: [ProductListResponseDTO] {
        guard !filterState.tagFilters.isEmpty else { return products }
        return products.filter { product in
            filterState.tagFilters.allSatisfy { product.tags.contains($0) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setDelegate()
        setUI()
        setLayout()
        setAction()
        fetchProductList()
        fetchCategories()
    }
}

private extension ListViewController {

    private func setDelegate() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.header.searchBar.delegate = self
        listView.header.onFilterSelectionChanged = { [weak self] titles in
            self?.filterState.tagFilters = Set(titles)
            self?.applyFilters()
        }
    }

    private func setUI() {
        view.addSubviews(listView, mapButton)
    }

    private func setLayout() {
        listView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        mapButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(34)
        }
    }

    private func setAction() {
        mapButton.addTarget(self, action: #selector(mapButtonDidTap), for: .touchUpInside)
    }

    @objc
    private func mapButtonDidTap() {
        navigateToMap()
    }

    func applyFilters() {
        let count = filteredProducts.count
        listView.tableView.reloadData()
        listView.emptyView.isHidden = count > 0
    }

    func fetchCategories() {
        Task {
            do {
                let categories: ProductCategoriesResponseDTO = try await BaseService.shared.request(
                    endPoint: .productCategories
                )
                await MainActor.run {
                    self.listView.header.configure(with: categories)
                }
            } catch {
                print("카테고리 조회 실패:", error)
            }
        }
    }

    func fetchProductList() {
        Task {
            do {
                let response = try await ProductService.shared.fetchProductList(
                    minPrice: filterState.minPrice,
                    maxPrice: filterState.maxPrice,
                    distanceCode: filterState.distanceCode
                )
                await MainActor.run {
                    self.products = response
                    self.applyFilters()
                }
            } catch {
                print("매물 목록 조회 실패:", error)
            }
        }
    }

    func navigateToMap() {
        let mapViewController = MapViewController()

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(mapViewController, animated: false)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let hasBanner = filteredProducts.count > 1
        return (hasBanner && indexPath.row == 2) ? 87 : 138
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let hasBanner = filteredProducts.count > 1
        guard hasBanner else { return }
        if indexPath.row == 1 || indexPath.row == 2 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let hasBanner = filteredProducts.count > 1
        if hasBanner && indexPath.row == 2 {
            navigateToMap()
        } else {
            let productIndex = (hasBanner && indexPath.row > 2) ? indexPath.row - 1 : indexPath.row
            let productId = filteredProducts[productIndex].productId
            navigationController?.pushViewController(ProductDetailViewController(productId: productId), animated: true)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = filteredProducts.count
        if count == 0 { return 0 }
        if count == 1 { return 1 }
        return count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hasBanner = filteredProducts.count > 1
        if hasBanner && indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
                return UITableViewCell()
            }
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let productIndex = (hasBanner && indexPath.row > 2) ? indexPath.row - 1 : indexPath.row
        cell.configure(with: filteredProducts[productIndex])
        return cell
    }
}

extension ListViewController: SearchBarHeaderDelegate {
    func filterButtonDidTap() {
        let bottomSheet = FilterBottomSheetViewController()
        bottomSheet.modalPresentationStyle = .overFullScreen
        bottomSheet.filterState = filterState
        bottomSheet.onApply = { [weak self] newState in
            guard let self else { return }
            self.filterState = newState
            self.listView.header.setSelectedFilters(newState.tagFilters)
            self.fetchProductList()
        }
        present(bottomSheet, animated: false)
    }
}
