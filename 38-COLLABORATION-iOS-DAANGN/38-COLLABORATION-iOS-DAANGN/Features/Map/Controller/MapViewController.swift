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

    private let mapImageView = UIImageView().then {
        $0.image = UIImage(named: "mapImageView")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let listButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()

        config.image = UIImage(named: "listIcon")?
            .withRenderingMode(.alwaysTemplate)

        config.imagePlacement = .leading
        config.imagePadding = 4

        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        )

        config.attributedTitle = AttributedString(
            NSAttributedString.styled(
                "목록 보기",
                style: .label3Regular,
                color: .gray00
            )
        )

        $0.configuration = config

        $0.tintColor = .gray00
        $0.backgroundColor = .gray1000
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    
    private let currentLocationButton = UIButton(type: .system).then {
        $0.setImage(
            UIImage(named: "locationIcon")?
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
    
    
    // MARK: 매물 칩 하드코딩
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
        price: "23,000원",
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

    // MARK: 라이프싸이클

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        setupHierarchy()
        setupLayout()
    }
    

    // MARK: 셋업

    private func setupStyle() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(mapImageView)
        view.addSubview(listButton)
        view.addSubview(currentLocationButton)
        
        // MARK: 매물 칩
        view.addSubview(firstProductChipView)
        view.addSubview(secondProductChipView)
        view.addSubview(thirdProductChipView)
        view.addSubview(fourthProductChipView)
        view.addSubview(fifthProductChipView)
        
        
    }

    private func setupLayout() {
        mapImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        listButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.width.equalTo(80)
            $0.height.equalTo(34)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(14)
            $0.size.equalTo(48)
        }
        
        // MARK: 매물 칩 UI 화면에 올리기
        firstProductChipView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(145)
            $0.leading.equalToSuperview().offset(37)
        }

        secondProductChipView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(110)
            $0.trailing.equalToSuperview().inset(15)
        }

        thirdProductChipView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(250)
            $0.trailing.equalToSuperview().inset(80)
        }

        fourthProductChipView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(300)
            $0.leading.equalToSuperview().offset(50)
        }

        fifthProductChipView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(370)
            $0.centerX.equalToSuperview()
        }
    }
}
