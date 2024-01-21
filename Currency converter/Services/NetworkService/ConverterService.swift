//
//  NetworkManager.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

protocol ConverterService {
    func getCurrencyConvertation(from: Currency, to: Currency, amount: Double) async throws -> Double
    func getCurrencyRates() async throws -> [Currency : Double]
}

extension HTTPClientImp {
    // TODO: get from config file
    private static let baseURL = "http://api.exchangeratesapi.io/v1/"
    static let converterServiceClient = HTTPClientImp(baseURL: baseURL)
}

final class ConverterServiceImp: ConverterService {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    private static let token = "c81ee97fae4797403c3aa645112942c6"
    
    func getCurrencyConvertation(from: Currency, to: Currency, amount: Double) async throws -> Double {
        let query = AmountQuery(accessKey: Self.token, from: from.rawValue, to: to.rawValue, amount: String(amount))
        return try await client.request(endpoint: L10n.Endpoint.convert, query: query)
    }
    
    func getCurrencyRates() async throws -> [Currency : Double] {
        let currencies = Currency.active
        var result: [Currency : Double] = [:]
        for currency in currencies {
            let symbols = currencies.filter { $0 != currency }.map { $0.rawValue }.joined(separator: ",")
            let query = RatesQuery(accessKey: Self.token, base: currency.rawValue, symbols: symbols)
            try await result.merge(client.request(endpoint: L10n.Endpoint.latest, query: query)) { current, _ in
                current
            }
        }
        
        return result
    }
}
