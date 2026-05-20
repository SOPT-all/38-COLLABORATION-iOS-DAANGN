//
//  ProductDetailResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/20/26.
//

struct ProductDetailResponseDTO: Decodable {
    let seller: Seller
    let title: String
    let price: Int
    let lastBumpedAt: String
    let content: String
    let tradeLocation: String
    let viewCount: Int
    let isLiked: Bool
    let tags: [String]
    let imageUrls: [String]
}

struct Seller: Decodable {
    let name: String
    let mannerTemperature: Float
    let address: String
}
