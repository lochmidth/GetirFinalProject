//
//  CartService.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 17.04.2024.
//

import Foundation

final class CartService {
    static let shared = CartService()
    
    private let coreDataManager: CoreDataManager
    var products = [Product]()
    
    init(coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
}
