//
//  DessertsFeedView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct DessertsFeedView: View {
    @StateObject var feedViewModel: DessertsFeedViewModel
    
    @State var presentingDessertId: String?
    
    var body: some View {
        VStack {
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
                                self.presentingDessertId = dessertPreview.id
                            }
                    }
                }
            }
        }
        .onAppear {
            feedViewModel.loadDessertsFeed()
        }
        .fullScreenCover(item: $presentingDessertId) { id in
            // TODO: Seems like sheets/fullscreencovers are currently causing issues with memory (See https://developer.apple.com/forums/thread/738840). Look for a work around that resolves this issue.
            DessertView(
                dessertViewModel: DessertViewModel(
                    withRepository: feedViewModel.repository,
                    id: id
                )
            ) {
                self.presentingDessertId = nil
            }
        }
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}

#Preview {
    DessertsFeedView(
        feedViewModel: DessertsFeedViewModel (
            withRepository: DessertsRepository()
        )
    )
}
