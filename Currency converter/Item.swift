//
//  Item.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
