//
//  ContentView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct MainPageView: View {
    var viewModel = DessertsFeedViewModel(
        withRepository: DessertsRepository()
    )
    
    var body: some View {
        VStack {
            DessertsFeedView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.loadDessertsFeed()
        }
    }
}

#Preview {
    MainPageView()
}
