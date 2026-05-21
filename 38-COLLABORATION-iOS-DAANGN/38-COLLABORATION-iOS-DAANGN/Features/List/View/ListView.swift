//
//  ListView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/14/26.
//

import UIKit

import SnapKit
import Then

final class ListView: UIView {

    lazy var header = FullHeader()
    let tableView = UITableView(frame: .zero, style: .plain)
    let emptyView = EmptyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ListView {
    private func setUI() {
        addSubviews(header, tableView, emptyView)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        tableView.separatorColor = .gray200
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        emptyView.isHidden = true
    }

    private func setLayout() {
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(189)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(11)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
    }
    
    private func register() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
    }
}
