//
//  DessertsFeedView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct DessertsFeedView: View {
    @StateObject var viewModel: DessertsFeedViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(viewModel.feed) { dessertPreview in
                    DessertPreviewView(dessertPreview: dessertPreview)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadDessertsFeed()
        }
    }
}

#Preview {
    DessertsFeedView(
        viewModel: DessertsFeedViewModel (
            withRepository: DessertsRepository()
        )
    )
}
