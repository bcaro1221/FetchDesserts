//
//  DessertsFeedViewModel.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import Foundation

class DessertsFeedViewModel: ObservableObject {
    @Published var feed: [DessertPreview] = []
    @Published var isLoading: Bool = false
    
    let repository: DessertsRepositoryProtocol
    
    init(withRepository repository: DessertsRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadDessertsFeed() {
        Task {
            await fetchDessertsFeed()
        }
    }
    
    private func fetchDessertsFeed() async {
        guard !isLoading else { return }
        
        self.isLoading = true
        
        do {
            self.feed = try await repository.fetchDessertPreviews()
        } catch {
            // TODO: Implement more robust error handling
            print("[-][DessertsFeedViewModel] Error fetching feed: \(error)")
        }
        
        self.isLoading = false
        
    }
}
