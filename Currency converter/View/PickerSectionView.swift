//
//  PickerSectionView.swift
//  Currency converter
//
//  Created by Leonid Safronov on 20.01.2024.
//

import SwiftUI

struct PickerSectionView: View {
    @Binding var firstCurrency: Currency
    @Binding var secondCurrency: Currency
    let firstPickerCurrencies: [Currency]
    let secondPickerCurrencies: [Currency]
    
    var body: some View {
        HStack(alignment: .center, spacing: 60) {
            VStack {
                Text(L10n.View.FirstPicker.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Picker(L10n.View.FirstPicker.name, selection: $firstCurrency) {
                    ForEach(firstPickerCurrencies) { currency in
                        Text(currency.rawValue.capitalized)
                    }
                }
            }
            
            VStack {
                Text(L10n.View.SecondPicker.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Picker(L10n.View.SecondPicker.name, selection: $secondCurrency) {
                    ForEach(secondPickerCurrencies) { currency in
                        Text(currency.rawValue.capitalized)
                    }
                }
            }
        }
        .padding()
    }
}
