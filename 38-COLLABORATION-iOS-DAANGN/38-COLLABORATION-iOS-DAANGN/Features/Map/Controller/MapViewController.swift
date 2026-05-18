//
//  MapViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class MapViewController: UIViewController {

    // MARK: UI
    
    private let statusBarBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }

    private let headerView = SimpleHeader()
    
    private let mapImageView = UIImageView().then {
        $0.image = UIImage(named: "mapImageView")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }

    private let listButton = ViewToggleButton(imageName: "listIcon", title: "목록 보기")
    
    private let currentLocationButton = UIButton(type: .system).then {
        $0.setImage(
                .crossHair?
                .withRenderingMode(.alwaysTemplate),
            for: .normal
        )

        $0.tintColor = .gray900
        $0.backgroundColor = .gray00

        $0.layer.cornerRadius = 24

        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 3
    }
    
    
    private let products = MapProduct.dummyList

    private let floatingView = MapProductFloatingView().then {
        $0.isHidden = true
        $0.alpha = 0
    }

    private var selectedProductIndex: Int?

    private var listButtonBottomConstraint: Constraint?
    
    private var currentLocationButtonBottomConstraint: Constraint?
    
    
    // MARK: 비선택된 매물 칩 하드코딩
    
    private let firstProductChipView = MapProductChipView(
        imageName: "img_product6",
        price: "28,000원",
    )

    private let secondProductChipView = MapProductChipView(
        imageName: "img_product5",
        price: "9,400원",
        isLiked: true
    )

    private let thirdProductChipView = MapProductChipView(
        imageName: "img_product4",
        price: "23,000원"
    )

    private let fourthProductChipView = MapProductChipView(
        imageName: "img_product1",
        price: "17,000원",
        isLiked: true
    )

    private let fifthProductChipView = MapProductChipView(
        imageName: "img_product2",
        price: "12,900원",
        isLiked: true
    )
    
    // MARK: 선택된 매물 칩 하드코딩
    
    private let selectedFirstProductChipView = SelectedMapProductChipView(
        imageName: "img_product6",
        title: "온둘라 LED 단스탠드",
        price: "28,000"
    )

    private let selectedSecondProductChipView = SelectedMapProductChipView(
        imageName: "img_product5",
        title: "이케아 조명",
        price: "9,400"
    )

    private let selectedThirdProductChipView = SelectedMapProductChipView(
        imageName: "img_product4",
        title: "웨이브 테이블 단스탠드 조명",
        price: "23,000"
    )

    private let selectedFourthProductChipView = SelectedMapProductChipView(
        imageName: "img_product1",
        title: "무드등 스탠드 조명",
        price: "17,000"
    )

    private let selectedFifthProductChipView = SelectedMapProductChipView(
        imageName: "img_product2",
        title: "페이퍼램프 급처",
        price: "12,900"
    )

    // MARK: 라이프싸이클

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        setupHierarchy()
        setupLayout()
        setupDelegate()
        setupAction()
    }
    

    // MARK: 셋업

    private func setupStyle() {
        view.backgroundColor = .white
        
        selectedFirstProductChipView.isHidden = true
        selectedSecondProductChipView.isHidden = true
        selectedThirdProductChipView.isHidden = true
        selectedFourthProductChipView.isHidden = true
        selectedFifthProductChipView.isHidden = true
    }

    private func setupHierarchy() {
        view.addSubview(mapImageView)
        view.addSubview(statusBarBackgroundView)
        view.addSubview(headerView)
        
        view.addSubview(floatingView)
        
        view.addSubview(listButton)
        view.addSubview(currentLocationButton)
        
        // MARK: 비선택된 매물 칩
        view.addSubview(firstProductChipView)
        view.addSubview(secondProductChipView)
        view.addSubview(thirdProductChipView)
        view.addSubview(fourthProductChipView)
        view.addSubview(fifthProductChipView)
        
        // MARK: 선택된 매물 칩
        view.addSubview(selectedFirstProductChipView)
        view.addSubview(selectedSecondProductChipView)
        view.addSubview(selectedThirdProductChipView)
        view.addSubview(selectedFourthProductChipView)
        view.addSubview(selectedFifthProductChipView)
        
        
    }

    private func setupLayout() {
        mapImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        statusBarBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(47)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(47)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }

        listButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            listButtonBottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            $0.width.equalTo(85)
            $0.height.equalTo(33)
        }

        currentLocationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            currentLocationButtonBottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(14).constraint
            $0.size.equalTo(48)
        }

        floatingView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.width.equalTo(347)
            $0.height.equalTo(140)
        }
        
        // MARK: 매물 칩 UI 화면에 올리기
        // headerView.snp.bottom 기준으로 통일 (safeArea 높이가 기기마다 달라서 생기는 위치 오차 방지)
        firstProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(97)
            $0.leading.equalToSuperview().offset(37)
        }

        secondProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(62)
            $0.trailing.equalToSuperview().inset(15)
        }

        thirdProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(202)
            $0.trailing.equalToSuperview().inset(80)
        }

        fourthProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(252)
            $0.leading.equalToSuperview().offset(50)
        }

        fifthProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(322)
            $0.centerX.equalToSuperview()
        }

        // MARK: 선택된 매물 칩 UI 화면에 올리기
        selectedFirstProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(97)
            $0.leading.equalToSuperview().offset(37)
        }

        selectedSecondProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(62)
            $0.trailing.equalToSuperview().inset(15)
        }

        selectedThirdProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(202)
            $0.trailing.equalToSuperview().inset(80)
        }

        selectedFourthProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(252)
            $0.leading.equalToSuperview().offset(50)
        }

        selectedFifthProductChipView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(322)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupDelegate() {
        headerView.searchBar.delegate = self
    }

    private func setupAction() {
        let mapTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapDidTap)
        )
        mapImageView.addGestureRecognizer(mapTapGesture)

        listButton.addTarget(
            self,
            action: #selector(listButtonDidTap),
            for: .touchUpInside
        )

        firstProductChipView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(firstProductChipDidTap))
        )
        secondProductChipView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(secondProductChipDidTap))
        )
        thirdProductChipView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(thirdProductChipDidTap))
        )
        fourthProductChipView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(fourthProductChipDidTap))
        )
        fifthProductChipView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(fifthProductChipDidTap))
        )
    }

    
    // MARK: 버튼 함수
    @objc
    private func listButtonDidTap() {
        let listViewController = ListViewController()

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(listViewController, animated: false)
    }
    
    private func deselectAllProductChips() {
        firstProductChipView.isHidden = false
        secondProductChipView.isHidden = false
        thirdProductChipView.isHidden = false
        fourthProductChipView.isHidden = false
        fifthProductChipView.isHidden = false

        selectedFirstProductChipView.isHidden = true
        selectedSecondProductChipView.isHidden = true
        selectedThirdProductChipView.isHidden = true
        selectedFourthProductChipView.isHidden = true
        selectedFifthProductChipView.isHidden = true
    }

    @objc
    private func firstProductChipDidTap() {
        selectProduct(at: 0)
    }

    @objc
    private func secondProductChipDidTap() {
        selectProduct(at: 1)
    }

    @objc
    private func thirdProductChipDidTap() {
        selectProduct(at: 2)
    }

    @objc
    private func fourthProductChipDidTap() {
        selectProduct(at: 3)
    }

    @objc
    private func fifthProductChipDidTap() {
        selectProduct(at: 4)
    }
    
    private func selectProduct(at index: Int) {
        deselectAllProductChips()

        selectedProductIndex = index

        switch index {
        case 0:
            firstProductChipView.isHidden = true
            selectedFirstProductChipView.isHidden = false
        case 1:
            secondProductChipView.isHidden = true
            selectedSecondProductChipView.isHidden = false
        case 2:
            thirdProductChipView.isHidden = true
            selectedThirdProductChipView.isHidden = false
        case 3:
            fourthProductChipView.isHidden = true
            selectedFourthProductChipView.isHidden = false
        case 4:
            fifthProductChipView.isHidden = true
            selectedFifthProductChipView.isHidden = false
        default:
            return
        }

        showFloatingView(product: products[index])
    }

    private func showFloatingView(product: MapProduct) {
        floatingView.configure(product: product)

        floatingView.isHidden = false

        listButtonBottomConstraint?.update(offset: -148)
        currentLocationButtonBottomConstraint?.update(inset: 154)

        UIView.animate(withDuration: 0.25) {
            self.floatingView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    private func hideFloatingView() {
        selectedProductIndex = nil
        deselectAllProductChips()

        listButtonBottomConstraint?.update(offset: 0)
        currentLocationButtonBottomConstraint?.update(inset: 14)

        UIView.animate(withDuration: 0.2) {
            self.floatingView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.floatingView.isHidden = true
        }
    }

    @objc
    private func mapDidTap() {
        hideFloatingView()
    }
}

extension MapViewController: SearchBarHeaderDelegate {
    func filterButtonDidTap() {
        let bottomSheet = FilterBottomSheetViewController()
        bottomSheet.modalPresentationStyle = .overFullScreen
        present(bottomSheet, animated: false)
    }

    func backButtonDidTap() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: false)
    }
}
