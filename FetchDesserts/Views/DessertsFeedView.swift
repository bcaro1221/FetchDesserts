//
//  DessertsFeedView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct DessertsFeedView: View {
    @StateObject var feedViewModel: DessertsFeedViewModel
    
    @State var dessertViewModel: DessertViewModel?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.blue
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                Text("Fetch Desserts!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(feedViewModel.feed) { dessertPreview in
                            DessertPreviewView(dessertPreview: dessertPreview)
                                .frame(width: 200, height: 250)
                                .padding(.horizontal, 1)
                                .onTapGesture {
                                    self.dessertViewModel = DessertViewModel(
                                        withRepository: DessertsRepository(),
                                        id: dessertPreview.id
                                    )
                                }
                        }
                    }
                }
                .frame(maxHeight: 400)
            }
            .padding(.horizontal)
        }
        .onAppear {
            feedViewModel.loadDessertsFeed()
        }
        .fullScreenCover(item: $dessertViewModel) { viewModel in
            VStack {
                Text("\(viewModel.id)")
                Button {
                    self.dessertViewModel = nil
                } label: {
                    Text("Dismiss")
                }
            }
                .onAppear {
                    viewModel.loadDessert()
                }
        }
    }
}

#Preview {
    DessertsFeedView(
        feedViewModel: DessertsFeedViewModel (
            withRepository: DessertsRepository()
        )
    )
}
