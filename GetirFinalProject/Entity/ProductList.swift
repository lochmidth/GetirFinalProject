//
//  Product.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation
import GetirSDK

struct ProductList {
    let id: String
    let name: String
    let productCount: Int
    let products: [Product]
    
    init(from dto: ProductListDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.productCount = dto.productCount ?? 0
        self.products = dto.products.map { Product(from: $0) }
    }
}
