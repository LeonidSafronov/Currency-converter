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

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Text("Currency converter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                PickerSectionView(firstCurrency: $viewModel.firstCurrency,
                                  firstPickerCurrencies: $viewModel.currenciesForFirstPicker,
                                  secondCurrency: $viewModel.secondCurrency,
                                  secondPickerCurrencies: $viewModel.currenciesForSecondPicker)
                .onChange(of: viewModel.firstCurrency) {
                    viewModel.saveFirstCurrency()
                }
                // TODO: don't apply change because of rewriting storage
                .onChange(of: viewModel.firstCurrency) {
                    viewModel.saveSecondCurrency()
                }
                HStack {
                    TextField(text: $viewModel.inputAmount, prompt: Text("Enter currency amount")) {
                        // TODO: clear on change of currencies or amount
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    Button("Done") {
                        // TODO: add flag for first use only
                        viewModel.appendItem()
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
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CurrencyStorage.self, inMemory: true)
}
