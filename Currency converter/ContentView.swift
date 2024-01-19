//
//  ContentView.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel = ConverterViewModel()
    @State private var inputValue: String = ""
    
    // TODO: add storage for screen state
    // TODO: refactor views for separate parts
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Currency converter")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack(alignment: .center, spacing: 60) {
                VStack {
                    Text("Convert from")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Picker("First Currency", selection: $viewModel.firstCurrency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue.capitalized)
                        }
                    }
                }
                VStack {
                    Text("Convert to")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Picker("Second Currency", selection: $viewModel.secondCurrency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue.capitalized)
                        }
                    }
                }
            }
            .padding()
            
            
            HStack {
                TextField(text: $viewModel.inputAmount, prompt: Text("Enter currency amount")) {
                    
                }
                .font(.title2)
                .fontWeight(.semibold)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                Button("Done") {
                    print()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 20)
            
            Text("Result")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(viewModel.convertedAmount ?? 0)")
                .font(.title)
                .fontWeight(.semibold)
            Text("No internet. Result based on data from \(viewModel.date)")
                .foregroundStyle(.red)
                .font(.title)
                .fontWeight(.semibold)
        }
        .onAppear {
            Task {
                await viewModel.getCurrencyRates()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
