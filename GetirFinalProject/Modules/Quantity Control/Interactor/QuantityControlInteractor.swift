//
//  QuantityControlInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantityControlInteractorDelegate: AnyObject {
    
}

protocol QuantityyControlInteractorOutput: AnyObject {
    
}

final class QuantityControlInteractor {
    
    weak var delegate: QuantityControlInteractorDelegate?
    
}

extension QuantityControlInteractor: QuantityControlInteractorInput {
    func addToCart() {
        
    }
    
    func removeFromCart() {
        
    }
}
