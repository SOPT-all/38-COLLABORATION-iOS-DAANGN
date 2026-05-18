//
//  NetworkError.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case decodingFailed
    case emptyData
    case unknown
}
