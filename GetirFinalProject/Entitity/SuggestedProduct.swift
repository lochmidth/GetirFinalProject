//
//  SuggestedProduct.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

struct SuggestedProductList {
    let id: String
    let name: String
    let products: [SuggestedProduct]
    
    struct SuggestedProduct {
        let id: String
        let imageURL: String
        let price: Double
        let name: String
        let priceText: String
        let shortDescription: String
        let category: String?
        let unitPrice: Double?
        let squareThumbnailURL: String
        let status: Int?
    }
}

