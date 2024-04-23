//
//  Product.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation
import GetirSDK

struct ProductList {
    var id = ""
    var name = ""
    var productCount = 0
    var products = [ProductCellPresenter]()
    
    mutating func update(from dto: ProductListDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.productCount = dto.productCount ?? 0
        self.products = dto.products?.compactMap { ProductCellPresenter(product: Product(from: $0)) } ?? []
    }
}
