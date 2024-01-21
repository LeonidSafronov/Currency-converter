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
    var timeStamp: Date
    
    init(firstCurrency: Currency, secondCurrency: Currency, currencyRates: [Currency : Double], timeStamp: Date) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
        self.currencyRates = currencyRates
        self.timeStamp = timeStamp
    }
}

final class CurrencyStorageDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = CurrencyStorageDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: CurrencyStorage.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(item: CurrencyStorage) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [CurrencyStorage] {
        do {
            return try modelContext.fetch(FetchDescriptor<CurrencyStorage>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: CurrencyStorage) {
        modelContext.delete(item)
    }
}
