//
//  CurrencyRate.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

struct CurrencyRate: Decodable {
    let first: Currency
    let second: [Currency]
    let value: [Double]
}

//let currencies: [String] = ["rubles (RUB)", "US dollars (USD)", "euro (EUR)", "British pound (GBP)", "Swiss franc (CHF)", "Chinese yuan (CNY)"]

enum Currency: String, CaseIterable, Identifiable, Decodable, Hashable {
    case RUB, USD, EUR, GBP, CHF, CNY, empty
    var id: Self { self }
}
