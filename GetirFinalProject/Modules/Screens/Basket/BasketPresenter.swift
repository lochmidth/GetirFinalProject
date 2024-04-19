//
//  BasketPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol BasketViewControllerInput: AnyObject {
    func configureNavigationbar()
    func configureCollectionView()
    func configureSubviews()
    func reload()
}

protocol BasketInteractorInput: AnyObject {
    var productList: ProductList { get }
    var suggestedProductList: SuggestedProductList { get }
    func fetchProducts()
}

protocol BasketRouterInput: AnyObject {
    var navigationController: UINavigationController! { get }
    func showAlert(with error: Error)
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
    func numberOfItemsInSection(_ section: Int) -> Int {
        if section == 0 {
            return interactor.productList.products.count
        } else {
            return interactor.suggestedProductList.products.count
        }
    }
    
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter {
        if indexPath.section == 0 {
            let presenter = interactor.productList.products[indexPath.item]
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        } else {
            let presenter = interactor.suggestedProductList.products[indexPath.item]
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        }
    }
    
    func viewDidLoad() {
        view.configureCollectionView()
        view.configureNavigationbar()
        view.configureSubviews()
        interactor.fetchProducts()
    }
}

extension BasketPresenter: BasketInteractorOutput {
    func didReceiveAllProducts() {
        view.reload()
    }
    
    func didFail(with error: any Error) {
        router.showAlert(with: error)
    }
}
