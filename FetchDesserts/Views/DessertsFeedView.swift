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
            Color.blue
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                Group {
                    Image(systemName: "birthday.cake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Text("Fetch Desserts!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                .foregroundColor(.white)
                .shadow(radius: 1)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(feedViewModel.feed) { dessertPreview in
                            DessertPreviewView(dessertPreview: dessertPreview)
                                .frame(maxWidth: 300)
                                .padding(1)
                                .onTapGesture {
                                    self.dessertViewModel = DessertViewModel(
                                        withRepository: DessertsRepository(),
                                        id: dessertPreview.id
                                    )
                                }
                        }
                    }
                }
                .frame(maxHeight: 300)
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            feedViewModel.loadDessertsFeed()
        }
        .fullScreenCover(item: $dessertViewModel) { viewModel in
            VStack {
                DessertView(dessertViewModel: viewModel)
                Button {
                    self.dessertViewModel = nil
                } label: {
                    Text("Dismiss")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
