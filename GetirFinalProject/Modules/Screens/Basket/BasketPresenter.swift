//
//  BasketPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import Foundation

protocol BasketViewControllerInput: AnyObject {
    
}

protocol BasketInteractorInput: AnyObject {
    
}

protocol BasketRouterInput: AnyObject {
    
}

final class BasketPresenter {
    
    weak var view: BasketViewControllerInput!
    var interactor: BasketInteractorInput
    var router: BasketRouterInput
    
    
    init(view: BasketViewControllerInput!, interactor: BasketInteractorInput, router: BasketRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension BasketPresenter: BasketViewControllerOutput {
    
}

extension BasketPresenter: BasketInteractorOutput {
    
}
