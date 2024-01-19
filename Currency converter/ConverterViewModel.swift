//
//  ConverterViewModel.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation
import SwiftUI

@Observable class ConverterViewModel {
    private let networkManager = NetworkManager.shared
    var currenciesForFirstPicker: [Currency] = Currency.allCases
    var firstCurrency: Currency = .empty // TODO: save it persistent
    var currenciesForSecondPicker: [Currency] {
        let array = currenciesForFirstPicker.filter({ $0 != firstCurrency })
        return array
    }
    var secondCurrency: Currency = .empty // TODO: save it persistent
    
    var inputAmount: String = ""
    var currencyRates: [Currency : Double] = [:]
    var convertedAmount: Double?
    let date = Date()
    
    func getCurrencyRates() async {
        do {
            try await currencyRates = networkManager.getCurrencyRates()
            // TODO: save it persistent
        } catch {
            // TODO: handle error
        }
    }
    
    func getConvertedAmount() async {
        do {
            try await convertedAmount = networkManager.getCurrencyConvertation(from: firstCurrency, to: secondCurrency, amount: Double(inputAmount) ?? 0)
        } catch {
            // TODO: handle error
        }
    }
}
