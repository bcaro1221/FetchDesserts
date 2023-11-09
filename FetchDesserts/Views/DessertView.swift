//
//  DessertView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/9/23.
//

import SwiftUI

struct DessertView: View {
    @StateObject var dessertViewModel: DessertViewModel
    
    var body: some View {
        Group {
            if dessertViewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let dessert = dessertViewModel.dessert {
                ScrollView(.vertical, showsIndicators: false) {
                    AsyncImage(url: dessert.url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipped()
                        } else if phase.error == nil {
                            ProgressView()
                                .padding()
                        } else {
                            Image(systemName: "photo")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(dessert.title)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.bottom)
                        
                        Text("Ingredients")
                            .font(.title2)
                        
                        ForEach(0..<dessert.ingredients.count, id: \.self) { index in
                            Text("• \(dessert.measurements[index]) \(dessert.ingredients[index])")
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                        }
                        
                        Text("Instructions")
                            .font(.title2)
                            .padding(.vertical)
                        Text(dessert.instructions)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
                .ignoresSafeArea()
            } else {
                // TODO: This is either the error state or the empty state, implement a way to distinguish and handle error better
                Color.clear
            }
        }
        .onAppear {
            dessertViewModel.loadDessert()
        }
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        DessertView(
            dessertViewModel: DessertViewModel(withRepository: DessertsRepository(), id: Dessert.testDessert.id)
        )
    }
}
