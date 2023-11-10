//
//  DessertViewModel.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/9/23.
//

import Foundation

@MainActor
class DessertViewModel: ObservableObject, Identifiable {
    @Published var dessert: Dessert? = nil
    @Published var isLoading: Bool = false
    
    let id: String
    
    private let repository: DessertsRepositoryProtocol
    
    init(withRepository repository: DessertsRepositoryProtocol, id: String) {
        self.repository = repository
        self.id = id
    }
    
    func loadDessert() {
        Task { [weak self] in
            await self?.fetchDessert()
        }
    }
    
    func fetchDessert() async {
        guard !self.isLoading else { return }
        
        self.isLoading = true
        do {
            self.dessert = try await repository.fetchDessert(for: self.id)
        } catch {
            // TODO: Implement more robust error handling
            print("[-][DessertViewModel] Error fetching dessert with id \(id): \(error)")
        }
        self.isLoading = false
    }
    
}
