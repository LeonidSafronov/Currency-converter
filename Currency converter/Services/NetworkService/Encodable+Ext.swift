//
//  Encodable+Ext.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import Foundation

extension Encodable {
    func queries() throws -> [URLQueryItem] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let data = try encoder.encode(self)
        let dict =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String : String]
        return dict.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
