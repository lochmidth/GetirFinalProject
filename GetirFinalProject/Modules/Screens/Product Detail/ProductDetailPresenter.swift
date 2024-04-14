//
//  ProductDetailPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import Foundation

protocol ProductDetailViewControllerInput: AnyObject {
    
}

protocol ProductDetailInteractorInput: AnyObject {
    
}

protocol ProductDetailRouterInput: AnyObject {
    
}

final class ProductDetailPresenter {
    
    weak var view: ProductDetailViewControllerInput!
    var interactor: ProductDetailInteractorInput
    var router: ProductDetailRouterInput
    
    init(view: ProductDetailViewControllerInput!, interactor: ProductDetailInteractorInput, router: ProductDetailRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProductDetailPresenter: ProductDetailViewControllerOutput {
    func viewDidLoad() {
        
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutput {
    
}
