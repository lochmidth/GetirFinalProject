//
//  ListingPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol ListingViewControllerInput: AnyObject {
    func configureNavigationBar()
    func reload(with products: ProductList, _ suggestedProducts: SuggestedProductList)
}

protocol ListingInteractorInput: AnyObject {
    func fetchAllProducts()
}

final class ListingPresenter {
    
    weak var controller: ListingViewControllerInput!
    var interactor: ListingInteractorInput
    
    init(controller: ListingViewControllerInput!, interactor: ListingInteractorInput) {
        self.controller = controller
        self.interactor = interactor
    }
}

extension ListingPresenter: ListingViewControllerOutput {
    func viewDidLoad() {
        controller.configureNavigationBar()
        interactor.fetchAllProducts()
    }
    
    func didTapCell() {
        print("Handle Show Product Detail")
    }
}

extension ListingPresenter: ListingInteractorOutput {
    func didReceiveAllProducts(_ products: ProductList, _ suggestedProducts: SuggestedProductList) {
        controller.reload(with: products, suggestedProducts)
    }
    
    func didFail(with error: any Error) {
        //Handle Error on Router with message..
    }
}
