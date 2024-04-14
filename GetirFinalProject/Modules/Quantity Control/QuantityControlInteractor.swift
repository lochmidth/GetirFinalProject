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
    var count = 0
}

extension QuantityControlInteractor: QuantityControlInteractorInput {
    func increaseCount() {
        count += 1
    }
    
    func decreaseCount() {
        if count > 0 {
            count -= 1
        }
    }
}
