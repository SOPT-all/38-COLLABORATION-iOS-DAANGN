//
//  AdProductListResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/20/26.
//

struct AdProductListResponseDTO: Decodable {
    let adProductId: Int
    let title: String
    let price: Int
    let seller: String
    let thumbnailUrl: String
}
