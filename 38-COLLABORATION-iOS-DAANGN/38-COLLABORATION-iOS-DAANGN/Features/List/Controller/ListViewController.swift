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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setDelegate()
        setUI()
        setLayout()
    }
}

private extension ListViewController {
    
    private func setDelegate() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    private func setUI() {
        view.addSubviews(listView)
    }
    
    private func setLayout() {
        listView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 138
        }
}
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 10
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(
                            withIdentifier: ListTableViewCell.identifier,
                            for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
          return cell
      }
}
