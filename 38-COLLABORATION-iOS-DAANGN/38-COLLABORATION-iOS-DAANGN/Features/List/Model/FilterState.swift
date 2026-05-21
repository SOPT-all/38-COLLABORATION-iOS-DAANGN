//
//  FilterState.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/21/26.
//

struct FilterState {
    var conditionCodes: Set<String> = []
    var tradeTypeCodes: Set<String> = []
    var priceInfoCodes: Set<String> = []
    var minPrice: Int? = nil
    var maxPrice: Int? = nil
    var distanceCode: String? = nil
}
