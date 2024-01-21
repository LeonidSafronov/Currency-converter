//
//  ContentView.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel = ConverterViewModel(
        dataSource: CurrencyStorageDataSource.shared,
        networkManager: ConverterServiceImp(client: HTTPClientImp.converterServiceClient)
    )

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(L10n.View.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            PickerSectionView(
                firstCurrency: .init(
                    get: { viewModel.firstCurrency },
                    set: { newValue in
                        viewModel.set(firstCurrency: newValue)
                    }
                ),
                secondCurrency: .init(
                    get: { viewModel.secondCurrency },
                    set: { newValue in
                        viewModel.set(secondCurrency: newValue)
                    }
                ),
                firstPickerCurrencies: viewModel.currenciesForFirstPicker,
                secondPickerCurrencies: viewModel.currenciesForSecondPicker
            )
            
            HStack {
                TextField(L10n.View.Textfield.name,text: $viewModel.inputAmount, prompt: Text(L10n.View.Textfield.placeholder))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                
                Button(L10n.View.Button.title) {
                    viewModel.appendItem()
                    Task {
                        await viewModel.getConvertedAmount(from: viewModel.firstCurrency, to: viewModel.secondCurrency, amount: Double(viewModel.inputAmount) ?? 0)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 20)
            
            ConvertedView(convertedAmount: $viewModel.convertedAmount)
            
            if viewModel.isErrorReceived {
                Text(L10n.View.warning(viewModel.date))
                    .foregroundStyle(.red)
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
        .task {
            viewModel.prepare()
            await viewModel.getCurrencyRates()
        }
        .overlay {
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
        .modelContainer(for: CurrencyStorageModel.self, inMemory: true)
}
