//
//  ProductListResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

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
