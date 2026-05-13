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
    
    private lazy var header = FullHeader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUI()
        setLayout()
    }
    
    private func setUI() {
        [header].forEach { self.view.addSubview($0) }
    }
    
    private func setLayout() {
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(189)
        }
    }
}
