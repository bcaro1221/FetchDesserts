//
//  DessertPreviewView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI
import SwURL

struct DessertPreviewView: View {
    let dessertPreview: DessertPreview
    
    var body: some View {
        VStack {
            if let url = dessertPreview.url {
                SwURLImage(url: url, placeholderImage: Image(systemName: "photo"))
                    .scaledToFit()
                    .clipped()
                    .frame(maxHeight: 200)
            } else {
                Image(systemName: "photo")
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
