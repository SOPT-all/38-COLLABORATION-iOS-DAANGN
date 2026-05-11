//
//  MapViewController.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/11/26.
//

import UIKit
import SnapKit

final class MapViewController: UIViewController {

    // UI

    private let mapImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "mapImageView")
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        return imageView
    }()

    // 라이프싸이클

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    // 레이아웃

    private func setupLayout() {
        view.backgroundColor = .white

        view.addSubview(mapImageView)

        mapImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
