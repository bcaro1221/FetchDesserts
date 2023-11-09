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
        ZStack(alignment: .leading) {
            Color.blue
                .ignoresSafeArea()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.feed) { dessertPreview in
                        DessertPreviewView(dessertPreview: dessertPreview)
                            .padding(.horizontal, 2)
                    }
                }
            }
            .frame(maxHeight: 400)
            .padding(.horizontal)
        }
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
