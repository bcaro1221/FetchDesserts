//
//  ContentView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct MainPageContainerView: View {
    
    var body: some View {
        VStack {
            DessertsFeedView(
                viewModel: DessertsFeedViewModel(
                withRepository: DessertsRepository()
            ))
        }
    }
}

#Preview {
    MainPageContainerView()
}
