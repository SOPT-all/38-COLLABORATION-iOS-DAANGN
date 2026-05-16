//
//  ViewToggleButton.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/16/26.
//

import UIKit

final class ViewToggleButton: UIButton {

    init(imageName: String, title: String) {
        super.init(frame: .zero)
        configure(imageName: imageName, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(imageName: String, title: String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .leading
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        self.configuration = config

        tintColor = .gray00
        backgroundColor = .gray1000
        layer.cornerRadius = 17
        clipsToBounds = true

        setConfigTitle(title, style: .label3Regular, color: .gray00)
    }
}
