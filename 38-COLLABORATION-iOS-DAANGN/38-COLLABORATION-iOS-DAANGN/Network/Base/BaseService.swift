//
//  BaseService.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 신서연 on 5/18/26.
//

import Foundation

final class BaseService {

    static let shared = BaseService()

    private init() {}

    func request<T: Decodable>(
        endPoint: EndPoint
    ) async throws -> T {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            throw NetworkError.invalidURL
        }

        var components = URLComponents(string: baseURL + endPoint.path)
        components?.queryItems = endPoint.queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue

        endPoint.header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }

            do {
                let decodedData = try JSONDecoder().decode(BaseResponseDTO<T>.self, from: data)

                guard let data = decodedData.data else {
                    throw NetworkError.emptyData
                }

                return data
            } catch let error as NetworkError {
                throw error
            } catch {
                print("디코딩 에러:", error)
                throw NetworkError.decodingFailed
            }

        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown
        }
    }
}
