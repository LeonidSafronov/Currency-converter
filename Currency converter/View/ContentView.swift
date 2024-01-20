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
    
    // TODO: add storage for first and second currency state
    
    @Environment(\.modelContext) private var modelContext
    @Query private var storage: [CurrencyStorage]

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Currency converter")
                .font(.largeTitle)
                .fontWeight(.bold)
            PickerSectionView(firstCurrency: $viewModel.firstCurrency, secondCurrency: $viewModel.secondCurrency)
            
            HStack {
                TextField(text: $viewModel.inputAmount, prompt: Text("Enter currency amount")) {
                    // TODO: ?
                }
                .font(.title2)
                .fontWeight(.semibold)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                Button("Done") {
                    Task {
                        await viewModel.getConvertedAmount(from: viewModel.firstCurrency, to: viewModel.secondCurrency, amount: Double(viewModel.inputAmount) ?? 0)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 20)
            
            ConvertedView(convertedAmount: $viewModel.convertedAmount)
            
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
        .modelContainer(for: CurrencyStorage.self, inMemory: true)
}
