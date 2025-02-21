//
//  Product.swift
//  ShoppingApp
//
//  Created by Jasvir on 2025-02-21.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
