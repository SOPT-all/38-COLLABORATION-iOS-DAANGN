//
//  EndPoint.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

import Foundation

enum EndPoint {
    case productList(
        minPrice: Int? = nil,
        maxPrice: Int? = nil,
        distanceCode: String? = nil,
        conditionCodes: Set<String> = [],
        tradeTypeCodes: Set<String> = [],
        priceInfoCodes: Set<String> = []
    )
    case adProductList
    case productDetail(productId: Int)
    case productCategories

    var path: String {
        switch self {
        case .productList:
            return "/api/v1/products"

        case .adProductList:
            return "/api/v1/products/ad"

        case .productDetail(let productId):
            return "/api/v1/products/\(productId)"

        case .productCategories:
            return "/api/v1/products/categories"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .productList,
             .adProductList,
             .productDetail,
             .productCategories:
            return .get
        }
    }

    var header: [String: String] {
        switch self {
        case .productList,
             .adProductList,
             .productDetail,
             .productCategories:
            return HeaderType.none.value
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .productList(let minPrice, let maxPrice, let distanceCode, let conditionCodes, let tradeTypeCodes, let priceInfoCodes):
            var items: [URLQueryItem] = []
            if let minPrice { items.append(URLQueryItem(name: "minPrice", value: "\(minPrice)")) }
            if let maxPrice { items.append(URLQueryItem(name: "maxPrice", value: "\(maxPrice)")) }
            if let distanceCode { items.append(URLQueryItem(name: "distanceCode", value: distanceCode)) }
            conditionCodes.forEach { items.append(URLQueryItem(name: "conditionCode", value: $0)) }
            tradeTypeCodes.forEach { items.append(URLQueryItem(name: "tradeTypeCode", value: $0)) }
            priceInfoCodes.forEach { items.append(URLQueryItem(name: "priceInfoCode", value: $0)) }
            return items.isEmpty ? nil : items
        default:
            return nil
        }
    }
}
