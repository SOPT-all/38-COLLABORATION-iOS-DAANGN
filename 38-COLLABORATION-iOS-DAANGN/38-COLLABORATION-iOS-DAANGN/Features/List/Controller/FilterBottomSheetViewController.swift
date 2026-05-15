//
//  FilterBottomSheetViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/15/26.
//

import UIKit

import Then
import SnapKit

class FilterBottomSheetViewController: UIViewController {

    private var isAppearAnimationCompleted = false
    private var isExpanded = false
    private let dimmedView = UIView()
    private let filterView = FilterBottomSheetView()
    private var partialHeightConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setUI()
        setLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard !isAppearAnimationCompleted else { return }
        filterView.transform = CGAffineTransform(translationX: 0, y: filterView.frame.height)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presentBottomSheet()
    }
}

private extension FilterBottomSheetViewController {

    func setStyle() {
        view.backgroundColor = .clear
        dimmedView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.3)
            $0.alpha = 0
        }
        filterView.do {
            $0.layer.cornerRadius = 16
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }

        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewDidTap))
        dimmedView.addGestureRecognizer(dimmedTap)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBarDidPan))
        filterView.addHandleBarGesture(panGesture)

        filterView.addCloseButtonTarget(self, action: #selector(closeButtonDidTap))
        filterView.resetButton.addTarget(self, action: #selector(resetButtonDidTap), for: .touchUpInside)
        filterView.applyButton.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
    }

    func setUI() {
        view.addSubviews(dimmedView, filterView)
    }

    func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        filterView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            partialHeightConstraint = $0.height.equalTo(view.bounds.height * 0.8).constraint
        }
    }

    func presentBottomSheet() {
        guard !isAppearAnimationCompleted else { return }
        isAppearAnimationCompleted = true

        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 1
            self.filterView.transform = .identity
        }
    }

    func expandToFull() {
        isExpanded = true
        partialHeightConstraint?.deactivate()
        filterView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 0
            self.filterView.transform = CGAffineTransform(translationX: 0, y: self.filterView.frame.height)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    @objc
    private func dimmedViewDidTap() {
        dismissBottomSheet()
    }

    @objc
    private func closeButtonDidTap() {
        dismissBottomSheet()
    }

    @objc
    private func resetButtonDidTap() {
        filterView.reset()
    }

    @objc
    private func applyButtonDidTap() {
        // TODO: 필터 적용 로직 연결
        dismissBottomSheet()
    }

    @objc
    private func handleBarDidPan(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: view).y
        let velocityY = gesture.velocity(in: view).y

        switch gesture.state {
        case .changed:
            if translationY > 0 {
                filterView.transform = CGAffineTransform(translationX: 0, y: translationY)
            } else if !isExpanded {
                filterView.transform = .identity
            }

        case .ended, .cancelled:
            if translationY > 80 || velocityY > 1000 {
                dismissBottomSheet()
            } else if translationY < -60 && !isExpanded {
                expandToFull()
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.filterView.transform = .identity
                }
            }

        default:
            break
        }
    }
}
