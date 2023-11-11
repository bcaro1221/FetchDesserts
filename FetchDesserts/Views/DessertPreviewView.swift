//
//  DessertPreviewView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI
import NukeUI

struct DessertPreviewView: View {
    let dessertPreview: DessertPreview
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LazyImage(url: dessertPreview.url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .accessibilityIdentifier("dessertPreviewImage")
                } else if phase.error == nil {
                    ProgressView()
                        .padding()
                } else {
                    Color.blue
                }
            }
            
            Text(dessertPreview.title.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .shadow(radius: 1)
                .padding()
                .accessibilityIdentifier("dessertPreviewTitle")
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
