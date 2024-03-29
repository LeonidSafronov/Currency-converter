//
//  Configuration.swift
//  Currency converter
//
//  Created by Leonid Safronov on 22.01.2024.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var baseURL: String {
        return try! Configuration.value(for: "BASE_URL")
    }
    static var apiKey: String {
        return try! Configuration.value(for: "API_KEY")
    }
}
