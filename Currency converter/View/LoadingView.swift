//
//  LoadingView.swift
//  Currency converter
//
//  Created by Leonid Safronov on 21.01.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.gray)
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
