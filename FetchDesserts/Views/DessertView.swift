//
//  DessertView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/9/23.
//

import SwiftUI

struct DessertView: View {
    @StateObject var dessertViewModel: DessertViewModel
    
    let dismissAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if dessertViewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let dessert = dessertViewModel.dessert {
                VStack {
                    Text(dessert.title.capitalized)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                        .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        AsyncImage(url: dessert.url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 350)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                                    .clipped()
                            } else if phase.error == nil {
                                ProgressView()
                                    .padding()
                            } else {
                                Image(systemName: "photo")
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Text("Ingredients")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.vertical, 20)
                            
                            ForEach(0..<dessert.ingredients.count, id: \.self) { index in
                                IngredientItemView(ingredient: dessert.ingredients[index], measurement: dessert.measurements[index])
                            }
                            
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.vertical, 20)
                            
                            
                            Text(dessert.instructions)
                                .padding(.horizontal)
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                // TODO: This is either the error state or the empty state, implement a way to distinguish and handle error better
                Color.clear
            }
            
            HStack {
                Button(action: dismissAction, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 15)
                        .foregroundColor(.white)
                        .padding(13)
                })
                .background(.blue)
                .clipShape(Circle())
                .padding(8)
                .opacity(0.8)
            }
            
        }
        .onAppear {
            dessertViewModel.loadDessert()
        }
    }
}

extension DessertView {
    struct IngredientItemView: View {
        let ingredient: String
        let measurement: String
        
        var body: some View {
            HStack {
                Text(ingredient)
                Spacer()
                Text(measurement)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .padding(5)
        }
    }
}

#Preview {
    DessertView(
        dessertViewModel: DessertViewModel(withRepository: DessertsRepository(), id: Dessert.testDessert.id)) {}
}
