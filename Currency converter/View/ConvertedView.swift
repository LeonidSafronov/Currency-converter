//
//  ConvertedView.swift
//  Currency converter
//
//  Created by Leonid Safronov on 20.01.2024.
//

import SwiftUI

struct ConvertedView: View {
    @Binding var convertedAmount: Double?
    
    var body: some View {
        VStack {
            Text(L10n.View.result)
                .font(.title)
                .fontWeight(.semibold)
            
            Text("\(convertedAmount ?? 0)")
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}
