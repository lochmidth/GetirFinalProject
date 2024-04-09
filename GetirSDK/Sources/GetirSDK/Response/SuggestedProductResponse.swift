//
//  File.swift
//  
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

public struct SuggestedProductListResponse: Codable {
    let id: String?
    let name: String?
    let products: [SuggestedProductResponse]
}

public struct SuggestedProductResponse: Codable {
    let id: String?
    let imageURL: String?
    let price: Double?
    let name: String?
    let priceText: String?
    let shortDescription: String?
    let category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
}
