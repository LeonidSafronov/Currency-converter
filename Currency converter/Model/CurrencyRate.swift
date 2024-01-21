//
//  CurrencyRate.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

enum Currency: String, CaseIterable, Identifiable, Codable, Hashable, Equatable {
    case RUB, USD, EUR, GBP, CHF, CNY, empty
    var id: Self { self }
}
