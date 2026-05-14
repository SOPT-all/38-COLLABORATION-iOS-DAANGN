//
//  RecommendProductModel.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/15/26.
//


import UIKit

struct RecommendProductModel {
    let success: Bool
    let status: String
    let message: String
    let data: [RecommendProduct]
}

struct RecommendProduct {
    let adProductId: Int
    let title: String
    let price: Int
    let seller: String
    let thumbnailUrl: String
}


extension RecommendProduct {
    static let dummyList: [RecommendProduct] = [
        RecommendProduct(
            adProductId: 1,
            title: "열매 포터블 램프 미니 (4 Options) 무선 조명 무드등",
            price: 41500,
            seller: "쿠팡",
            thumbnailUrl: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQU6UGlOP2DCbnFNlYjgge96uLAPmCSj2b_8p_BY1OeveAJ2vPJROnRhmzlU_B-qIO2ck-GmAwG32ApU6m7f7K7g60qlT6AJ6K3S08YZnvT&usqp=CAc"
        ),
        RecommendProduct(
            adProductId: 2,
            title: "[레토] 무선 머쉬룸 무드등 인테리어 LED 조명 램프 수유등 수면등 집들이선물",
            price: 24000,
            seller: "쿠팡",
            thumbnailUrl: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSFjHjegEfQmD9q3emEyBNXQq6zxuKx1ISQfvnoxzoRd9PCNME4fnOBj-AzLDrgDwowxyrRm4OZOjZ6A3xxKM9thjCWlOvUgLaT-YYmROE&usqp=CAc"
        ),
        RecommendProduct(
            adProductId: 3,
            title: "루아즈 패브릭 수유등 단스탠드 무드등",
            price: 19800,
            seller: "오늘의집",
            thumbnailUrl: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRCMyg-Ni3kp25fWBTPJMCEgyTaSd1P2eX8CoJvFjHf7OAp8ri-rYvYkkH88k4UUpPAb9hzCD62WCfxYIEHzTpbl5YnTXdFP1inGJdPj5Y&usqp=CAc"
        ),
        RecommendProduct(
            adProductId: 4,
            title: "LED 미니 침실 무드등",
            price: 12900,
            seller: "네이버쇼핑",
            thumbnailUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRvtw6tZ7b19OHRsWM3xE58qp55FsXFvAXGw&s"
        ),
        RecommendProduct(
            adProductId: 5,
            title: "우드 테이블 스탠드 조명",
            price: 32900,
            seller: "쿠팡",
            thumbnailUrl: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRCMyg-Ni3kp25fWBTPJMCEgyTaSd1P2eX8CoJvFjHf7OAp8ri-rYvYkkH88k4UUpPAb9hzCD62WCfxYIEHzTpbl5YnTXdFP1inGJdPj5Y&usqp=CAc"
        )
    ]
}

extension RecommendProductModel {
    static let dummy = RecommendProductModel(
        success: true,
        status: "AD_PRODUCT_LIST_SUCCESS",
        message: "광고 상품 목록 조회 성공",
        data: RecommendProduct.dummyList
    )
}
