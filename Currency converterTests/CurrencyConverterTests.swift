//
//  CurrencyConverterTests.swift
//  Currency converterTests
//
//  Created by Leonid Safronov on 19.01.2024.
//

import XCTest
@testable import Currency_converter

class ConverterServiceStub: ConverterService {
    func getCurrencyConvertation(from: Currency, to: Currency, amount: Double) async throws -> Double {
        .zero
    }

    func getCurrencyRates() async throws -> [Currency : Double] {
        [.RUB: 10]
    }
}

class CurrencyStorageDataSourceStub: DataSource {
    func appendItem(item: CurrencyStorageModel) throws {
        
    }
    
    func fetchItems() throws -> [CurrencyStorageModel] {
        return []
    }
}

final class CurrencyConverterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCurrencyRates() async throws {
        // given
        let viewModel = ConverterViewModel(dataSource: CurrencyStorageDataSourceStub(), networkManager: ConverterServiceStub())
        
        // when
        await viewModel.getCurrencyRates()
        
        // then
        XCTAssertTrue(viewModel.currencyRates == [Currency.RUB: 10],  "WRONG CURRENCY RATES")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
