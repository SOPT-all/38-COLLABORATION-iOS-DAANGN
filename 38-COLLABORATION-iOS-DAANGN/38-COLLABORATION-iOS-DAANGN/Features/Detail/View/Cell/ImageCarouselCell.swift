//
//  ImageCarouselCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class ImageCarouselCell: UICollectionViewCell {
    static let identifier = "ImageCarouselCell"
    
    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImageCarouselCell {
    
    func setUI() {
        contentView.addSubview(productImageView)
    }
    
    func setLayout() {
        productImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ImageCarouselCell {
    
    func dataBind(imageURL: String) {
        productImageView.kf.setImage(with: URL(string: imageURL))
    }
}
