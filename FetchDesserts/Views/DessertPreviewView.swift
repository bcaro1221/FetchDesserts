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
        VStack {
            
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
                    Image(systemName: "photo")
                }
            }
            
            Text(dessertPreview.title)
                .font(.caption)
                .fontWeight(.bold)
                .padding()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        DessertPreviewView(dessertPreview: DessertPreview.testDessertPreview)
    }
}
