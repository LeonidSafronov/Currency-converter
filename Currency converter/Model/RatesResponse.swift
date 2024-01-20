//
//  ConverterResponse.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

struct RatesResponse: Decodable {
    let timeStamp: Int
    let date: Date
    let base: Currency
    let rates: [Currency : Double] // can it be serialized in this way?
}

struct AmountResponse: Decodable {
    let result: Double
}

// TODO: clear
//{
//    "success": true,
//    "query": {
//        "from": "GBP",
//        "to": "JPY",
//        "amount": 25
//    },
//    "info": {
//        "timestamp": 1519328414,
//        "rate": 148.972231
//    },
//    "historical": ""
//    "date": "2018-02-22"
//    "result": 3724.305775
//}

//{
//    "success": true,
//    "timestamp": 1519296206,
//    "base": "USD",
//    "date": "2021-03-17",
//    "rates": {
//        "GBP": 0.72007,
//        "JPY": 107.346001,
//        "EUR": 0.813399,
//    }
//}
