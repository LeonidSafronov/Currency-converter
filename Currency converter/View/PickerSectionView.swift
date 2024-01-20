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
    
    var body: some View {
        HStack(alignment: .center, spacing: 60) {
            VStack {
                Text("Convert from")
                    .font(.title2)
                    .fontWeight(.semibold)
                Picker("First Currency", selection: $firstCurrency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.rawValue.capitalized)
                    }
                }
            }
            VStack {
                Text("Convert to")
                    .font(.title2)
                    .fontWeight(.semibold)
                Picker("Second Currency", selection: $secondCurrency) {
                    ForEach(Currency.allCases) { currency in
                        Text(currency.rawValue.capitalized)
                    }
                }
            }
        }
        .padding()
    }
}