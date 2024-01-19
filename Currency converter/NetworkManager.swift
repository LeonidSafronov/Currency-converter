//
//  NetworkManager.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    // TODO: save token to file
    private static let baseURL = "http://api.exchangeratesapi.io/v1/"
    private static let token = "c81ee97fae4797403c3aa645112942c6"
    
//    data from model given from user in UI and for saving history by default
    var from = "USD"
    var to = "EUR"
    var amount = 0
    var base = "RUB" // use all currencies for base one by one
    var symbols = "USD,CAD,EUR" // use all currencies by default
//http://api.exchangeratesapi.io/v1/latest?access_key=c81ee97fae4797403c3aa645112942c6&symbols=USD,CAD,EUR&format=1
    // as to be
    //http://api.exchangeratesapi.io/v1/convert?access_key=c81ee97fae4797403c3aa645112942c6&from=EUR&to=JPY&amount=25
    
//    latest
//      ? access_key = API_KEY
//      & base = GBP
//      & symbols = USD,CAD,EUR
    
//    convert
//        ? access_key = API_KEY
//        & from = GBP
//        & to = JPY
//        & amount = 25
    
    private init() {}
    
    func getCurrencyConvertation(from: Currency, to: Currency, amount: Double) async throws -> Double {
        let convertationURL = NetworkManager.baseURL + "convert?access_key=" + NetworkManager.token + "&from=\(from)" + "&to=\(to)" + "&amount=\(amount)"
        guard let url = URL(string: convertationURL) else {
            throw ConverterError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw ConverterError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AmountResponse.self, from: data).result
        } catch {
            throw ConverterError.invalidData
        }
    }
    
    func getCurrencyRates() async throws -> [Currency : Double] {
        let currencyRateURL = NetworkManager.baseURL + "latest?access_key=" + NetworkManager.token + "&base=\(base)" + "&symbols=\(symbols)" + "&format=1"
        guard let url = URL(string: currencyRateURL) else {
            throw ConverterError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw ConverterError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(RatesResponse.self, from: data).rates
        } catch {
            throw ConverterError.invalidData
        }
    }
}
