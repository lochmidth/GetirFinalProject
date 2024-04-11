//
//  ListingPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

protocol ListingViewControllerInput: AnyObject {
    func configureNavigationBar()
    func reload(with products: ProductList, _ suggestedProducts: SuggestedProductList)
}

protocol ListingInteractorInput: AnyObject {
    func fetchAllProducts()
}

protocol ListingRouterInput: AnyObject {
    func showAlert(with error: Error)
    func buildCell(with collectionView: UICollectionView, _ indexPath: IndexPath) -> ProductCell
}

final class ListingPresenter {
    
    weak var controller: ListingViewControllerInput!
    var interactor: ListingInteractorInput
    var router: ListingRouterInput
    
    init(controller: ListingViewControllerInput!, interactor: ListingInteractorInput, router: ListingRouterInput) {
        self.controller = controller
        self.interactor = interactor
        self.router = router
    }
}

extension ListingPresenter: ListingViewControllerOutput {
    func buildCell(with collectionView: UICollectionView, _ indexPath: IndexPath, _ navigationController: UINavigationController) -> ProductCell {
        return router.buildCell(with: collectionView, indexPath)
    }
    
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
        router.showAlert(with: error)
    }
}
