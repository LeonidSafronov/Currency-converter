//
//  Queries.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import Foundation

struct RatesQuery: Encodable {
    let accessKey: String
    let base: String
    let symbols: String
}

struct AmountQuery: Encodable {
    let from: String
    let to: String
    let amount: String
}
