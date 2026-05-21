//
//  ProductService.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/19/26.
//

import Foundation

final class ProductService {

    static let shared = ProductService()

    private init() {}

    func fetchProductList(
        minPrice: Int? = nil,
        maxPrice: Int? = nil,
        distanceCode: String? = nil,
        conditionCodes: Set<String> = [],
        tradeTypeCodes: Set<String> = [],
        priceInfoCodes: Set<String> = []
    ) async throws -> [ProductListResponseDTO] {
        return try await BaseService.shared.request(
            endPoint: .productList(
                minPrice: minPrice,
                maxPrice: maxPrice,
                distanceCode: distanceCode,
                conditionCodes: conditionCodes,
                tradeTypeCodes: tradeTypeCodes,
                priceInfoCodes: priceInfoCodes
            )
        )
    }
}
