//
//  ProductDetailViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit

final class ProductDetailViewController: UIViewController {
    
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
    }
    
    func setUI() {
        view.addSubview(bottomBarView)
        bottomBarView.chatButton.addTarget(
            self,
            action: #selector(chatButtonDidTap),
            for: .touchUpInside
        )
    }
    
    func setLayout() {
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
}
