//
//  DessertsRepository.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import Foundation

protocol DessertsRepositoryProtocol {
    func fetchDessertPreviews() async throws -> [DessertPreview]
    func fetchDessert(for id: String) async throws -> Dessert
}

struct DessertsRepository: DessertsRepositoryProtocol {
    func fetchDessertPreviews() async throws -> [DessertPreview] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        
        async let (data, _) = URLSession.shared.data(from: url)
        
        let dessertsResult = try await JSONDecoder().decode(DessertsResult<DessertPreview>.self, from: data)
        return dessertsResult.meals.sorted()
    }
    
    func fetchDessert(for id: String) async throws -> Dessert {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        
        async let (data, _) = URLSession.shared.data(from: url)
        
        let dessertsResult = try await JSONDecoder().decode(DessertsResult<Dessert>.self, from: data)
        return dessertsResult.meals[0]
    }
}
