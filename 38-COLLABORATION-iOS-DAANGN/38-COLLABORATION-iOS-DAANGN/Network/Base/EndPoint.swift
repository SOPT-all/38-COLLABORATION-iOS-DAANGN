//
//  EndPoint.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

enum EndPoint {
    case productList
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
            return "/api/v1/product/categories"
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
}
