//
//  SuggestedProduct.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation
import GetirSDK

struct SuggestedProductList {
    var id = ""
    var name = ""
    var products = [ProductCellPresenter]()
    
    mutating func update(from dto: SuggestedProductListDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.products = dto.products?.compactMap { ProductCellPresenter(product: Product(from: $0)) } ?? []
    }
}
