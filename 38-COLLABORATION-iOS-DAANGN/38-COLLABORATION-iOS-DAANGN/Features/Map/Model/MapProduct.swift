//
//  MapProduct.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/16/26.
//


import Foundation

// MARK: 구조체 형식
struct MapProduct {
    let imageName: String
    let title: String
    let address: String
    let time: String
    let price: String
    let tags: [String]
    let isLiked: Bool
}

// MARK: 매물 익스텐션
extension MapProduct {
    static let dummyList: [MapProduct] = [
        MapProduct(
            imageName: "img_product6",
            title: "온둘라 LED 단스탠드",
            address: "수원 고등동",
            time: "끌올 16분 전",
            price: "28,000원",
            tags: ["사용감 있음", "직거래", "택배 가능"],
            isLiked: false
        ),
        MapProduct(
            imageName: "img_product5",
            title: "이케아 조명",
            address: "수원 지동",
            time: "끌올 16분 전",
            price: "9,400원",
            tags: ["새상품", "문고리 거래", "택배 가능"],
            isLiked: true
        ),
        MapProduct(
            imageName: "img_product4",
            title: "웨이브 테이블 단스탠드 조명",
            address: "수원 탑동",
            time: "끌올 16분 전",
            price: "23,000원",
            tags: ["새상품", "미개봉", "직거래", "문고리 거래"],
            isLiked: false
        ),
        MapProduct(
            imageName: "img_product1",
            title: "무드등 스탠드 조명",
            address: "수원 매산로1가",
            time: "끌올 16분 전",
            price: "17,000원",
            tags: ["새상품", "문고리 거래", "택배 가능"],
            isLiked: true
        ),
        MapProduct(
            imageName: "img_product2",
            title: "페이퍼램프 급처",
            address: "수원 탑동",
            time: "끌올 16분 전",
            price: "12,900원",
            tags: ["새상품", "문고리 거래"],
            isLiked: true
        )
    ]
}
