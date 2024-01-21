//
//  DataSource.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import SwiftData

protocol DataSource {
    func appendItem(item: CurrencyStorageModel) throws
    func fetchItems() throws -> [CurrencyStorageModel]
}

final class CurrencyStorageDataSource: DataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = CurrencyStorageDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: CurrencyStorageModel.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(item: CurrencyStorageModel) throws {
        modelContext.insert(item)
        try modelContext.save()
    }

    func fetchItems() throws -> [CurrencyStorageModel] {
        try modelContext.fetch(FetchDescriptor<CurrencyStorageModel>())
    }
}
