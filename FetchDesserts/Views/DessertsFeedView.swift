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
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Image(systemName: "birthday.cake")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Fetch Desserts!")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                }
                .padding()
                .foregroundColor(.blue)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {   
                        ForEach(feedViewModel.feed) { dessertPreview in
                            DessertPreviewView(dessertPreview: dessertPreview)
                                .frame(maxWidth: 350)
                                .padding(1)
                                .shadow(radius: 0.2)
                                .onTapGesture {
                                    self.dessertViewModel = DessertViewModel(
                                        withRepository: DessertsRepository(),
                                        id: dessertPreview.id
                                    )
                                }
                        }
                    }
                }
            }
        }
        .onAppear {
            feedViewModel.loadDessertsFeed()
        }
        .fullScreenCover(item: $dessertViewModel) { viewModel in
            VStack {
                DessertView(dessertViewModel: viewModel) {
                    self.dessertViewModel = nil
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
