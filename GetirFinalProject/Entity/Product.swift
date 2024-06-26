//
//  Product.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation
import GetirSDK

struct Product {
    let id: String
    let name: String
    let attribute: String
    let imageURL: URL?
    let price: Double
    let priceText: String
    var quantity: Int = 0
    
    init(id: String, name: String, attribute: String, imageURL: URL?, price: Double, priceText: String) {
        self.id = id
        self.name = name
        self.attribute = attribute
        self.imageURL = imageURL
        self.price = price
        self.priceText = priceText
    }
    
    init(from dto: ProductDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.attribute = dto.attribute ?? (dto.shortDescription ?? "")
        self.imageURL = URL(string: dto.imageURL ?? (dto.thumbnailURL ?? ""))
        self.price = dto.price ?? 0.0
        self.priceText = dto.priceText ?? ""
    }
    
    init(from dto: SuggestedProductDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.attribute = dto.shortDescription ?? (dto.attribute ?? "")
        self.imageURL = URL(string: dto.squareThumbnailURL ?? (dto.imageURL ?? ""))
        self.price = dto.price ?? 0.0
        self.priceText = dto.priceText ?? ""
    }
}
