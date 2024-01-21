//
//  ConverterViewModel.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation
import SwiftUI
import SwiftData

@Observable class ConverterViewModel {
    
    // MARK: Storing data
    
    @ObservationIgnored
        private let dataSource: CurrencyStorageDataSource

    var items: [CurrencyStorage] = [CurrencyStorage(firstCurrency: .empty, secondCurrency: .empty, currencyRates: [:], timeStamp: Date())]

        init(dataSource: CurrencyStorageDataSource = CurrencyStorageDataSource.shared) {
            self.dataSource = dataSource
            items = dataSource.fetchItems()
            guard let storedFirstCurrency = items.last?.firstCurrency,
                  let storedSecondCurrency = items.last?.secondCurrency else {
                return
            }
            firstCurrency = storedFirstCurrency
            secondCurrency = storedSecondCurrency
        }

    func appendItem() {
        dataSource.appendItem(item: CurrencyStorage(firstCurrency: self.firstCurrency, secondCurrency: self.secondCurrency, currencyRates: self.currencyRates, timeStamp: self.date))
    }
    
    // MARK: Parameters
    
    var currenciesForFirstPicker: [Currency] = Currency.allCases
    var firstCurrency: Currency = .empty
    var currenciesForSecondPicker: [Currency] = Currency.allCases
    var secondCurrency: Currency = .empty
    var inputAmount: String = ""
    var currencyRates: [Currency : Double] = [:]
    var convertedAmount: Double?
    let date = Date()
    
    var alertItem: AlertItem?
    
    func saveFirstCurrency() {
        items.last?.firstCurrency = firstCurrency
        currenciesForFirstPicker = Currency.allCases.filter { $0 != .empty }
    }
    func saveSecondCurrency() {
        items.last?.secondCurrency = secondCurrency
        currenciesForFirstPicker = Currency.allCases.filter { $0 != .empty }
        
    }
    
    // MARK: Networking
    
    private let networkManager = NetworkManager.shared
    var isLoading = false
    
    func getCurrencyRates() async {
        do {
            currencyRates = try await networkManager.getCurrencyRates()
            items.last?.currencyRates = currencyRates
        } catch {
            if let apError = error as? ConverterError {
                switch apError {
                case .invalidURL:
                    alertItem = AlertContext.invalidURL
                case .invalidResponse:
                    alertItem = AlertContext.invalidResponse
                case .invalidData:
                    alertItem = AlertContext.invalidData
                case .unableToComplete:
                    alertItem = AlertContext.unableToComplete
                }
            }
            else {
                alertItem = AlertContext.smthGoesWrong
            }
            guard let storedRates = items.last?.currencyRates else {
                return
            }
            currencyRates = storedRates
        }
    }
    
    func getConvertedAmount(from firstCurrency: Currency, to secondCurrency: Currency, amount: Double) async {
        do {
             convertedAmount = try await networkManager.getCurrencyConvertation(from: firstCurrency, to: secondCurrency, amount: amount)
            isLoading = false
        } catch {
            if let apError = error as? ConverterError {
                switch apError {
                case .invalidURL:
                    alertItem = AlertContext.invalidURL
                case .invalidResponse:
                    alertItem = AlertContext.invalidResponse
                case .invalidData:
                    alertItem = AlertContext.invalidData
                case .unableToComplete:
                    alertItem = AlertContext.unableToComplete
                }
            }
            else {
                alertItem = AlertContext.smthGoesWrong
            }
            isLoading = false
        }
    }
}
