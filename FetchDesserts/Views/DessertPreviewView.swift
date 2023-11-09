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
            AsyncImage(url: dessertPreview.url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                } else if phase.error != nil {
                    ProgressView()
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .padding()
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
