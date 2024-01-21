//
//  HTTPClient.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import Foundation

protocol HTTPClient {
    func request<T: Decodable>(endpoint: String, query: Encodable) async throws -> T
}

final class HTTPClientImp: HTTPClient {
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(endpoint: String, query: Encodable) async throws -> T {
        guard var url = URL(string: baseURL) else {
            throw HTTPClientError.invalidURL
        }

        let queryItems = try query.queries()
        url.append(queryItems: queryItems)
        url.append(path: endpoint)
        
        let (data, response) = try await session.data(from: url)
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            throw HTTPClientError.invalidResponse
        }
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            throw HTTPClientError.invalidData
        }
        return result
    }
}

