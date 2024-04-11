//
//  SuggestedProduct.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation
import GetirSDK

struct SuggestedProductList {
    let id: String
    let name: String
    let products: [Product]
    
    init(from dto: SuggestedProductListDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.products = dto.products.map { Product(from: $0) }
    }
}

//struct SuggestedProduct {
//    let id: String
//    let imageURL: String
//    let price: Double
//    let name: String
//    let priceText: String
//    let shortDescription: String
//    let category: String
//    let unitPrice: Double
//    let squareThumbnailURL: String
//    let status: Int
//    
//    init(from dto: SuggestedProductDTO) {
//        self.id = dto.id ?? ""
//        self.imageURL = dto.imageURL ?? ""
//        self.price = dto.price ?? 0.0
//        self.name = dto.name ?? ""
//        self.priceText = dto.priceText ?? ""
//        self.shortDescription = dto.shortDescription ?? ""
//        self.category = dto.category ?? ""
//        self.unitPrice = dto.unitPrice ?? 0.0
//        self.squareThumbnailURL = dto.squareThumbnailURL ?? ""
//        self.status = dto.status ?? 0
//    }
//}

