//
//  ProductCategoriesResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/19/26.
//

struct ProductCategoriesResponseDTO: Decodable {
    let conditions: [Condition]
    let tradeTypes: [TradeType]
    let priceInfos: [PriceInfo]
}

struct Condition: Decodable {
    let code: String
    let name: String
}

struct TradeType: Decodable {
    let code: String
    let name: String
}

struct PriceInfo: Decodable {
    let code: String
    let name: String
}
