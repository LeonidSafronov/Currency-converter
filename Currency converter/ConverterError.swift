//
//  ConverterError.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation

enum ConverterError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
