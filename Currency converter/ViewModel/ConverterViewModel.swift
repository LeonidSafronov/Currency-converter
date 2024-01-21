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
    
    @ObservationIgnored
    private let dataSource: DataSource
    private let networkManager: ConverterService
    
    var items: [CurrencyStorageModel] = [CurrencyStorageModel(firstCurrency: .empty, secondCurrency: .empty, currencyRates: [:], timeStamp: Date())]
    
    init(dataSource: DataSource, networkManager: ConverterService) {
        self.dataSource = dataSource
        self.networkManager = networkManager
    }
    
    func appendItem() {
        do {
            try dataSource.appendItem(item: CurrencyStorageModel(firstCurrency: firstCurrency, secondCurrency: secondCurrency, currencyRates: currencyRates, timeStamp: date))
        } catch {
            handleDataSourceError(error)
        }
    }
    
    var currenciesForFirstPicker: [Currency] = Currency.allCases
    var firstCurrency: Currency = .empty
    var currenciesForSecondPicker: [Currency] = Currency.allCases
    var secondCurrency: Currency = .empty
    var inputAmount: String = ""
    var currencyRates: [Currency : Double] = [:]
    var convertedAmount: Double?
    var date: Date {
        items.last?.timeStamp ?? Date()
    }
    
    var alertItem: AlertItem?
    
    func saveFirstCurrency() {
        items.last?.firstCurrency = firstCurrency
        currenciesForFirstPicker = Currency.active
    }
    func saveSecondCurrency() {
        items.last?.secondCurrency = secondCurrency
        currenciesForFirstPicker = Currency.active
    }
    
    func prepare() {
        do {
            items = try dataSource.fetchItems()
        } catch {
            handleDataSourceError(error)
        }
        guard let storedFirstCurrency = items.last?.firstCurrency,
              let storedSecondCurrency = items.last?.secondCurrency
        else {
            return
        }
        firstCurrency = storedFirstCurrency
        secondCurrency = storedSecondCurrency
    }
    
    var isLoading = false
    var isErrorReceived = true
    
    func set(firstCurrency: Currency) {
        self.firstCurrency = firstCurrency
        saveFirstCurrency()
    }
    
    func set(secondCurrency: Currency) {
        self.secondCurrency = secondCurrency
        saveSecondCurrency()
    }
    
    func getCurrencyRates() async {
        do {
            currencyRates = try await networkManager.getCurrencyRates()
            items.last?.currencyRates = currencyRates
        } catch {
            handleHTTPError(error)
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
            isErrorReceived = false
        } catch {
            handleHTTPError(error)
        }
    }
    
    private func handleHTTPError(_ error: Error) {
        if let netError = error as? HTTPClientError {
            switch netError {
            case .invalidURL:
                alertItem = .invalidURL
            case .invalidResponse:
                alertItem = .invalidResponse
            case .invalidData:
                alertItem = .invalidData
            case .unableToComplete:
                alertItem = .unableToComplete
            }
        }
        else {
            alertItem = .smthGoesWrong
        }
        isLoading = false
        isErrorReceived = true
    }
    
    private func handleDataSourceError(_ error: Error) {
        if let dataError = error as? DataSourceError {
            switch dataError {
            case .invalidDataSaving:
                alertItem = .invalidDataSaving
            case .invalidDataLoading:
                alertItem = .invalidDataLoading
            }
        }
        else {
            alertItem = .smthGoesWrong
        }
    }
}
