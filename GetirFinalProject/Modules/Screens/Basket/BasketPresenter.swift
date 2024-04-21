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
    func didTapCheckout() {
        let alert = UIAlertController(title: "", message: "Siparişi onaylıyor musunuz?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Evet", style: .default) { [weak self] _ in
            guard let self = self else { return }
            interactor.checkout()
        }
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        router.navigationController.present(alert, animated: true)
    }


    
    func didTapTrashButton() {
        let alert = UIAlertController(title: "", message: "Sepeti temizlemek istediğinden emin misin?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Evet", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            interactor.handleClearAllProducts()
        }
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel)
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        router.navigationController.present(alert, animated: true)
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
    
    func viewDidLoad() {
        view.configureNavigationbar()
        view.configureCollectionView()
        view.configureSubviews()
        interactor.fetchProducts()
    }
}

extension BasketPresenter: BasketInteractorOutput {
    func didCheckout() {
        let confirmAlert = UIAlertController(title: "Siparişin onaylandı!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default) { [weak self] _ in
            guard let self = self else { return }
            router.dismissBasket()
        }
        confirmAlert.addAction(action)
        Task { @MainActor in
            router.navigationController.present(confirmAlert, animated: true)
        }
    }
    
    func didUpdateProductList(withPrice priceText: String) {
        view.reload(withPrice: priceText)
    }
    
    func didClearCart() {
        router.dismissBasket()
    }
    
    func didFail(with error: any Error) {
        router.showAlert(with: error)
    }
}

extension BasketPresenter: BasketDelegate {
    func didQuantityChange(for product: Product) {
        interactor.adjustCart(with: product)
    }
}
