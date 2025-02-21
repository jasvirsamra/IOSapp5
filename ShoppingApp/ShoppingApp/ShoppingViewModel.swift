//
//  ShoppingViewModel.swift
//  ShoppingApp
//
//  Created by Jasvir on 2025-02-21.
//

import Foundation

@MainActor
class ShoppingViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchQuery: String = ""
    private let apiService = ShoppingAPIService()

    func loadProducts() async {
        do {
            self.products = try await apiService.fetchProducts()
        } catch {
            print("❌ Error fetching products: \(error.localizedDescription)")
        }
    }

    func searchForProducts() async {
        guard !searchQuery.isEmpty else {
            await loadProducts()
            return
        }
        
        do {
            self.products = try await apiService.searchProducts(query: searchQuery)
        } catch {
            print("❌ Error searching products: \(error.localizedDescription)")
        }
    }
}

