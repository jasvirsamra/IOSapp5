//
//  ShoppingAPIService.swift
//  ShoppingApp
//
//  Created by Jasvir on 2025-02-21.
//

import Foundation

class ShoppingAPIService {
    private let apiKey = "YOUR_API_KEY"
    private let apiHost = "fakestoreapi.com"

    func fetchProducts() async throws -> [Product] {
        let urlString = "https://fakestoreapi.com/products"
        return try await fetchFromAPI(urlString: urlString)
    }

    func searchProducts(query: String) async throws -> [Product] {
        let formattedQuery = query.lowercased()
        let urlString = "https://fakestoreapi.com/products/category/\(formattedQuery)"
        return try await fetchFromAPI(urlString: urlString)
    }

    private func fetchFromAPI(urlString: String) async throws -> [Product] {
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL: \(urlString)")
            throw URLError(.badURL)
        }

        print("🔗 Requesting: \(urlString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Response Code: \(httpResponse.statusCode)")

                if httpResponse.statusCode != 200 {
                    let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                    print("❌ API Error: \(httpResponse.statusCode) - \(errorMessage)")
                    throw URLError(.badServerResponse)
                }
            }

            do {
                return try JSONDecoder().decode([Product].self, from: data)
            } catch {
                print("❌ JSON Decoding Error: \(error)")
                throw error
            }
        } catch {
            print("❌ Network Request Failed: \(error.localizedDescription)")
            throw error
        }
    }
}
