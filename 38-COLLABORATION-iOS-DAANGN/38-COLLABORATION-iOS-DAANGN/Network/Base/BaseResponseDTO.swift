//
//  BaseResponseDTO.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

struct BaseResponseDTO<T: Decodable>: Decodable {
    let success: Bool
    let status: String
    let message: String
    let data: T?
}
