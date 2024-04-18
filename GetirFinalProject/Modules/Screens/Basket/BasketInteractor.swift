//
//  BasketInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import Foundation

protocol BasketInteractorOutput: AnyObject {
    
}

final class BasketInteractor {
    
    weak var presenter: BasketInteractorOutput!
}

extension BasketInteractor: BasketInteractorInput {
    
}
