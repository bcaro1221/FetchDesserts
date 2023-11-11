//
//  ContentView.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import SwiftUI

struct MainPageContainerView: View {
    
    let repository: DessertsRepositoryProtocol = ProcessInfo.processInfo.arguments.contains("Testing") ? DessertsRepositoryStub() : DessertsRepository()
    
    var body: some View {
        DessertsFeedView(
            feedViewModel: DessertsFeedViewModel(
            withRepository: repository
        ))
    }
}

#Preview {
    MainPageContainerView()
}
