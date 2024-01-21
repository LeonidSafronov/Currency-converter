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
        title: Text("Server Error"),
        message: Text("The data received from the server was invalid. Please contact support."),
        dismissButton: .default(Text("OK"))
    )
    static let invalidResponse = AlertItem(
        title: Text("Server Error"),
        message: Text("Invalid response from the server. Please try again later or contact support."),
        dismissButton: .default(Text("OK"))
    )
    static let invalidURL = AlertItem(
        title: Text("Server Error"),
        message: Text("There was an issue connecting to server. If this persists, please contact support."),
        dismissButton: .default(Text("OK"))
    )
    static let unableToComplete = AlertItem(
        title: Text("Server Error"),
        message: Text("Unable to complete your request at this time. Please check your internet connection."),
        dismissButton: .default(Text("OK"))
    )
    
    static let smthGoesWrong = AlertItem(
        title: Text("Server Error"),
        message: Text("Something goes wrong."),
        dismissButton: .default(Text("OK"))
    )
    
    //MARK: - DataSource Alerts
    
    static let invalidDataSaving = AlertItem(
        title: Text("DataSource Error"),
        message: Text("Unable to save data."),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidDataLoading = AlertItem(
        title: Text("DataSource Error"),
        message: Text("Unable to load data."),
        dismissButton: .default(Text("OK"))
    )
}
