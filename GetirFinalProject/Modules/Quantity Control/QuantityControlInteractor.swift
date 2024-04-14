//
//  QuantityControlInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantityControlInteractorOutput: AnyObject {
    var count: Int { get set }
}

final class QuantityControlInteractor {
    
    weak var presenter: QuantityControlInteractorOutput!
}

extension QuantityControlInteractor: QuantityControlInteractorInput {
    func increaseCount() {
        presenter.count += 1
    }
    
    func decreaseCount() {
        if presenter.count > 0 {
            presenter.count -= 1
        }
    }
}
