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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setDelegate()
        setUI()
        setLayout()
        setAction()
        fetchProductList()
    }
}

private extension ListViewController {

    private func setDelegate() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.header.searchBar.delegate = self
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

    func fetchProductList() {
        Task {
            do {
                let response = try await ProductService.shared.fetchProductList()
                await MainActor.run {
                    self.products = response
                    self.listView.tableView.reloadData()
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
        return indexPath.row == 2 ? 87 : 138
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 2 {
            navigateToMap()
        } else {
            let productIndex = indexPath.row < 2 ? indexPath.row : indexPath.row - 1
            let productId = products[productIndex].productId
            navigationController?.pushViewController(ProductDetailViewController(productId: productId), animated: true)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.isEmpty ? 0 : products.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
                return UITableViewCell()
            }
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let productIndex = indexPath.row < 2 ? indexPath.row : indexPath.row - 1
        cell.configure(with: products[productIndex])
        return cell
    }
}

extension ListViewController: SearchBarHeaderDelegate {
    func filterButtonDidTap() {
        let bottomSheet = FilterBottomSheetViewController()
        bottomSheet.modalPresentationStyle = .overFullScreen
        present(bottomSheet, animated: false)
    }
}
