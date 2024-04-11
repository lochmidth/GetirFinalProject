//
//  QuantityControlInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantityControlInteractorOutput: AnyObject {
    
}

final class QuantityControlInteractor {
    
    weak var presenter: QuantityControlInteractorOutput!
    
}

extension QuantityControlInteractor: QuantityControlInteractorInput {
    func addToCart() {
        
    }
    
    func removeFromCart() {
        
    }
}
