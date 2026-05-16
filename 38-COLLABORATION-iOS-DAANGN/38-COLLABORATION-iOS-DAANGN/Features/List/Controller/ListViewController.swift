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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setDelegate()
        setUI()
        setLayout()
        setAction()
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
        if indexPath.row == 2 {
            return 87
        }
        return 138
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard indexPath.row == 2 else { return }
        navigateToMap()
    }
}
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 11
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
                return UITableViewCell()
            }
            return bannerCell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
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
