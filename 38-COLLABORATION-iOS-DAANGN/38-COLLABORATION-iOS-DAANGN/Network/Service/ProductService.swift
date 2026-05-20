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

    func fetchProductList() async throws -> [ProductListResponseDTO] {
        return try await BaseService.shared.request(
            endPoint: .productList
        )
    }
}
