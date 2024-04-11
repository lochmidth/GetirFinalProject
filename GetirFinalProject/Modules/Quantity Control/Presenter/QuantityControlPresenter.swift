//
//  QuantityControlPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantitiyControlViewInput: AnyObject {
    func configureUI()
    func configureStack(with orientation: StackOrientation)
    func updateStack()
}

protocol QuantityControlInteractorInput: AnyObject {
    func addToCart()
    func removeFromCart()
}

final class QuantityControlPresenter {
    
    //MARK: - Properties
    
    private weak var view: QuantitiyControlViewInput!
    
    //MARK: - Lifecycle
    
    init(view: QuantitiyControlViewInput!) {
        self.view = view
    }
    
    //MARK: - Helpers
    
}

extension QuantityControlPresenter: QuantitiyControlViewOutput {
    func configure() {
        view.configureUI()
        view.configureStack(with: .horizontal)
    }
    
    func incrementQuantity() {
        //Handle Cart
    }
    
    func decrementQuantity() {
        //Handle Cart
    }
}
