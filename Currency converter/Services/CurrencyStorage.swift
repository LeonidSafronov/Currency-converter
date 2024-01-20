//
//  Item.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation
import SwiftData

@Model
final class CurrencyStorage {
    var firstCurrency: Currency
    var secondCurrency: Currency
    var currencyRates: [Currency : Double]
    
    init(firstCurrency: Currency, secondCurrency: Currency, currencyRates: [Currency : Double]) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
        self.currencyRates = currencyRates
    }
}
