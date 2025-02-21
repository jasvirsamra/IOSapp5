//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Jasvir on 2025-02-21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ShoppingViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search products...", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        Task {
                            await viewModel.searchForProducts()
                        }
                    }

                List(viewModel.products) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text("$\(product.price, specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                    }
                }
                .navigationTitle("Shopping App")
                .task {
                    await viewModel.loadProducts()
                }
            }
        }
    }
}

