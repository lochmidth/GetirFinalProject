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
    func reload(withPrice priceText: String)
    func showLoading()
    func hideLoading()
}

protocol BasketInteractorInput: AnyObject {
    var productList: ProductList { get }
    var suggestedProductList: SuggestedProductList { get }
    func fetchProducts()
    func adjustCart(with product: Product)
    func checkout()
    func clearProduct(_ product: Product)
    func handleClearAllProducts()
}

protocol BasketRouterInput: AnyObject {
    var navigationController: UINavigationController! { get }
    func dismissBasket()
    func showCheckoutMessage()
    func showClearAllMessage()
    func showDidCheckoutMessage()
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
    func viewDidLoad() {
        view.showLoading()
        view.configureNavigationbar()
        view.configureCollectionView()
        view.configureSubviews()
        interactor.fetchProducts()
    }
    
    func didTapCheckout() {
        view.showLoading()
        router.showCheckoutMessage()
    }
    
    func didTapTrashButton() {
        view.showLoading()
        router.showClearAllMessage()
    }
    
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
            presenter.quantityControlPresenter?.basketDelegate = self
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        } else {
            let presenter = interactor.suggestedProductList.products[indexPath.item]
            presenter.quantityControlPresenter?.basketDelegate = self
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        }
    }
}

extension BasketPresenter: BasketInteractorOutput {
    func didCheckout() {
        router.showDidCheckoutMessage()
        view.hideLoading()
    }
    
    func didUpdateProductList(withPrice priceText: String) {
        view.reload(withPrice: priceText)
        view.hideLoading()
    }
    
    func didClearCart() {
        router.dismissBasket()
        view.hideLoading()
    }
    
    func didFail(with error: any Error) {
        view.hideLoading()
        router.showAlert(with: error)
    }
}

extension BasketPresenter: BasketRouterOutput {
    func didTapClearAllButton() {
        interactor.handleClearAllProducts()
    }
    
    func didTapCancelButton() {
        view.hideLoading()
    }
    
    func didTapCheckoutButton() {
        interactor.checkout()
    }
}

extension BasketPresenter: BasketDelegate {
    func didQuantityChange(for product: Product) {
        view.showLoading()
        interactor.adjustCart(with: product)
    }
}
