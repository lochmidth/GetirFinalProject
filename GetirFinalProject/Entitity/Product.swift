//
//  Product.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

struct ProductList {
    let id: String
    let name: String
    let productCount: Int
    let products: [Product]
    
    struct Product {
        let id: String
        let name: String
        let attribute: String
        let thumbnailURL: String
        let imageURL: String
        let price: Double
        let priceText: String
    }
}

