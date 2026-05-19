//
//  ProductListResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

import Foundation

struct ProductListResponseDTO: Decodable {
    let productId: Int
    let title: String
    let tradeLocation: String
    let lastBumpedAt: String
    let price: Int
    let thumbnailUrl: String
    let likeCount: Int
    let tags: [String]
    let isLiked: Bool
}


extension ProductListResponseDTO {
    func toMapProduct() -> MapProduct {
        return MapProduct(
            imageName: thumbnailUrl,
            title: title,
            address: tradeLocation,
            time: "끌올 몇분 전",
            price: "\(price.formatted())원",
            tags: tags,
            isLiked: isLiked
        )
    }
}
