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

    // UI

    private let mapImageView = UIImageView().then {
        $0.image = UIImage(named: "mapImageView")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let listButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()

        config.title = "목록 보기"
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

        var title = AttributedString("목록 보기")
        title.font = FontStyle.label3Regular.font
        title.foregroundColor = .gray00
        config.attributedTitle = title

        $0.configuration = config

        $0.tintColor = .gray00
        $0.backgroundColor = .gray1000
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }

    // 라이프싸이클

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        setupHierarchy()
        setupLayout()
    }

    // 셋업

    private func setupStyle() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(mapImageView)
        view.addSubview(listButton)
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
    }
}
