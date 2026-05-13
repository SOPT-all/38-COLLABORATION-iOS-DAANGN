//
//  BottomSheetViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit

final class BottomSheetViewController: UIViewController {
    
    private var isAppearAnimationCompleted = false
    private let dimmedView = UIView()
    private let bottomSheetView = BottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard !isAppearAnimationCompleted else { return }
        bottomSheetView.transform = CGAffineTransform(
            translationX: 0,
            y: bottomSheetView.frame.height
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentBottomSheet()
    }
}

private extension BottomSheetViewController {
    
    func setStyle() {
        view.backgroundColor = .clear
        dimmedView.backgroundColor = .black.withAlphaComponent(0.5)
        bottomSheetView.layer.cornerRadius = 16
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomSheetView.clipsToBounds = true
        dimmedView.alpha = 0
        bottomSheetView.onSendButtonTapped = { [weak self] in
            self?.dismissBottomSheet()
        }
        
        let dimmedTapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewDidTap))
        dimmedView.addGestureRecognizer(dimmedTapGesture)
        
        let handleBarPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBarDidPan))
        bottomSheetView.addHandleBarGesture(handleBarPanGesture)
    }
    
    func setUI() {
        view.addSubviews(dimmedView, bottomSheetView)
    }
    
    func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentBottomSheet() {
        guard !isAppearAnimationCompleted else { return }
        isAppearAnimationCompleted = true
        
        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 1
            self.bottomSheetView.transform = .identity
        }
    }
    
    @objc
    private func dimmedViewDidTap() {
        dismissBottomSheet()
    }
    
    @objc
    private func handleBarDidPan(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: view).y
        
        switch gesture.state {
        case .changed:
            guard translationY > 0 else { return }
            bottomSheetView.transform = CGAffineTransform(translationX: 0, y: translationY)
            
        case .ended, .cancelled:
            if translationY > 80 {
                dismissBottomSheet()
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.bottomSheetView.transform = .identity
                }
            }
            
        default:
            break
        }
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 0
            self.bottomSheetView.transform = CGAffineTransform(
                translationX: 0,
                y: self.bottomSheetView.frame.height
            )
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
