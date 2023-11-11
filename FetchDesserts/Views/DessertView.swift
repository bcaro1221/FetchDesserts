//
//  DessertView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/9/23.
//

import SwiftUI
import NukeUI

struct DessertView: View {
    @StateObject var dessertViewModel: DessertViewModel
    
    let dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            if dessertViewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let dessert = dessertViewModel.dessert, false {
                VStack {
                    Text(dessert.title.capitalized)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                        .padding()
                        .accessibilityIdentifier("dessertTitleText")
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyImage(url: dessert.url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 350)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                                    .clipped()
                                    .accessibilityIdentifier("dessertImage")
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
                                .padding(.vertical, 10)
                            
                            ForEach(0..<dessert.ingredients.count, id: \.self) { index in
                                IngredientItemView(ingredient: dessert.ingredients[index], measurement: dessert.measurements[index])
                            }
                            
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                            
                            
                            Text(dessert.instructions)
                                .font(.caption)
                                .padding()
                                .background(.gray.opacity(0.2))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                                .padding(5)
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                Text("Unable to load data")
                    .font(.title)
            }
            
            VStack {
                HStack {
                    Button {
                        dismissAction()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(8)
                    }
                    .background(.blue)
                    .clipShape(Circle())
                    .opacity(0.8)
                    .accessibilityIdentifier("backButton")
                    .frame(maxWidth: 30)
                    .padding()
                    
                    Spacer()
                }
                Spacer()
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
                    .font(.caption)
                Spacer()
                Text(measurement)
                    .font(.caption)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .padding(5)
        }
    }
}

#Preview {
    DessertView(
        dessertViewModel: DessertViewModel(withRepository: DessertsRepository(), id: Dessert.testDessert.id)) {}
}
