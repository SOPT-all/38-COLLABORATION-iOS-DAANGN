//
//  ImageCarouselCell.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

import SnapKit
import Then

final class ImageCarouselCell: UICollectionViewCell {
    static let identifier = "ImageCarouselCell"
    
    private let gradientLayer = CAGradientLayer()
    
    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let gradientView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.bringSubviewToFront(gradientView)
        gradientLayer.frame = gradientView.bounds
    }
}

private extension ImageCarouselCell {
    
    func setStyle() {
        let gradientColor = UIColor(
            red: 176 / 255,
            green: 179 / 255,
            blue: 186 / 255,
            alpha: 1
        )
        
        gradientLayer.colors = [
            gradientColor.cgColor,
            gradientColor.withAlphaComponent(0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    func setUI() {
        contentView.addSubviews(productImageView, gradientView)
        gradientView.isUserInteractionEnabled = false
        gradientView.clipsToBounds = true
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    func setLayout() {
        productImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.48)
        }
    }
}

extension ImageCarouselCell {
    
    func dataBind(imageName: String) {
        productImageView.image = UIImage(named: imageName)
        setNeedsLayout()
        layoutIfNeeded()
    }
}
