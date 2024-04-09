//
//  File.swift
//  
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

import Foundation

public struct ProductListResponse: Codable {
    let id: String?
    let name: String?
    let productCount: Int?
    let products: [ProductResponse]
}

public struct ProductResponse: Codable {
    let id: String?
    let name: String?
    let attribute: String?
    let thumbnailURL: String?
    let imageURL: String?
    let price: Double?
    let priceText: String?
}
