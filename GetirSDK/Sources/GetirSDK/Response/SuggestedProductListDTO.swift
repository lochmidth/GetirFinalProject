//
//  File.swift
//  
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

public struct SuggestedProductListDTO: Codable {
    public let id: String?
    public let name: String?
    public let products: [SuggestedProductDTO]
}

public struct SuggestedProductDTO: Codable {
    public let id: String?
    public let imageURL: String?
    public let price: Double?
    public let name: String?
    public let priceText: String?
    public let shortDescription: String?
    public let category: String?
    public let unitPrice: Double?
    public let squareThumbnailURL: String?
    public let status: Int?
}
