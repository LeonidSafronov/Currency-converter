//
//  Alert.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

extension AlertItem {
    
    //MARK: - Network Alerts
    
    static let invalidData = AlertItem(
        title: Text(L10n.Error.server),
        message: Text(L10n.InvalidData.message),
        dismissButton: .default(Text(L10n.ok))
    )
    static let invalidResponse = AlertItem(
        title: Text(L10n.Error.server),
        message: Text(L10n.InvalidResponse.message),
        dismissButton: .default(Text(L10n.ok))
    )
    static let invalidURL = AlertItem(
        title: Text(L10n.Error.server),
        message: Text(L10n.InvalidURL.message),
        dismissButton: .default(Text(L10n.ok))
    )
    static let unableToComplete = AlertItem(
        title: Text(L10n.Error.server),
        message: Text(L10n.UnableToComplete.message),
        dismissButton: .default(Text(L10n.ok))
    )
    
    static let smthGoesWrong = AlertItem(
        title: Text(L10n.Error.server),
        message: Text(L10n.SmthGoesWrong.message),
        dismissButton: .default(Text(L10n.ok))
    )
    
    //MARK: - DataSource Alerts
    
    static let invalidDataSaving = AlertItem(
        title: Text(L10n.Error.dataSource),
        message: Text(L10n.InvalidDataSaving.message),
        dismissButton: .default(Text(L10n.ok))
    )
    
    static let invalidDataLoading = AlertItem(
        title: Text(L10n.Error.dataSource),
        message: Text(L10n.InvalidDataLoading.message),
        dismissButton: .default(Text(L10n.ok))
    )
}
