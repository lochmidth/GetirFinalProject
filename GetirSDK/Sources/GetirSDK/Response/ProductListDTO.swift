//
//  File.swift
//  
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

public struct ProductListDTO: Codable {
    public let id: String?
    public let name: String?
    public let productCount: Int?
    public let products: [ProductDTO]
}

public struct ProductDTO: Codable {
    public let id: String?
    public let name: String?
    public let attribute: String?
    public let thumbnailURL: String?
    public let imageURL: String?
    public let price: Double?
    public let priceText: String?
}