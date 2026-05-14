//
//  ProductDetailModel.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/11/26.
//

import UIKit

struct ProductDetailResponse {
    let success: Bool
    let status: String
    let message: String
    let data: ProductDetailData?
}

struct ProductDetailData {
    let seller: Seller
    let title: String
    let price: Int
    let lastBumpedAt: String
    let content: String
    let tradeLocation: String
    let viewCount: Int
    let isLiked: Bool
    let tags: [String]
    let imageURLs: [String] // API 명세서 추가 요청
}

struct Seller {
    let name: String
    let mannerTemperature: Float
    let address: String
}

extension ProductDetailData {
    static let dummy = ProductDetailData(
        seller: Seller(
            name: "당근이",
            mannerTemperature: 36.5,
            address: "서초구 서초동"
        ),
        title: "빈티지 조명",
        price: 30000,
        lastBumpedAt: "2026-05-13T12:00:00",
        content: "미사용 새상품 스탠드 조명입니다. 인테리어용으로 두려고 구매했는데 사용하지 않아 판매해요. 부드러운 조명이라 침실, 거실 무드등으로 활용하기 좋습니다 :) 상태 완전 새상품 그대로이며, 바로 사용 가능합니다. 직거래 선호하고 시간 맞추면 빠르게 거래 가능해요! 편하게 문의 주세요 🙌",
        tradeLocation: "서초역 3번 출구",
        viewCount: 128,
        isLiked: false,
        tags: ["직거래", "상태좋음"],
        imageURLs: ["img_product1", "img_product2", "img_product3", "img_product4", "img_product5"]
    )
}
