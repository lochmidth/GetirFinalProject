//
//  MockProducts.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

let mockProduct1 = Product(id: "1", name: "Mock Product 1", attribute: "Attribute 1", imageURL: URL(string: "https://example.com/image1.jpg"), price: 10.99, priceText: "₺10.99")
let mockProduct2 = Product(id: "2", name: "Mock Product 2", attribute: "Attribute 2", imageURL: URL(string: "https://example.com/image2.jpg"), price: 20.49, priceText: "₺20.49")

let mockProducts: [Product] = [mockProduct1, mockProduct2]
