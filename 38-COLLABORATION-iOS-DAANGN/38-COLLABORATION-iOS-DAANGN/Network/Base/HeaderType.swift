//
//  HeaderType.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

enum HeaderType {
    case basic
    case none

    var value: [String: String] {
        switch self {
        case .basic:
            return [
                "Content-Type": "application/json"
            ]

        case .none:
            return [:]
        }
    }
}
