//
//  CurrencyStorageModel.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation
import SwiftData

@Model
final class CurrencyStorageModel {
    var firstCurrency: Currency
    var secondCurrency: Currency
    var currencyRates: [Currency : Double]
    var timeStamp: Date
    
    init(firstCurrency: Currency, secondCurrency: Currency, currencyRates: [Currency : Double], timeStamp: Date) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
        self.currencyRates = currencyRates
        self.timeStamp = timeStamp
    }
}
