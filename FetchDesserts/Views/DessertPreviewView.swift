//
//  DessertPreviewView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct DessertPreviewView: View {
    let dessertPreview: DessertPreview
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            // TODO: Find a suitable replacement library for Async Images
            AsyncImage(url: dessertPreview.url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                } else if phase.error == nil {
                    ProgressView()
                        .padding()
                } else {
                    // TODO: Implement more robust error handling
                    Color.blue
                }
            }
            
            Text(dessertPreview.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .shadow(radius: 1)
                .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ZStack {
        Color.clear
            .ignoresSafeArea()
        DessertPreviewView(dessertPreview: DessertPreview.testDessertPreview)
    }
}
