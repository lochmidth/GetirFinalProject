//
//  ListingPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

protocol ListingViewControllerInput: AnyObject {
    func configureNavigationBar()
    func configureCollectionView()
    func configureSubviews()
    func reload()
    func showLoading()
    func hideLoading()
}

protocol ListingInteractorInput: AnyObject {
    var productList: ProductList { get }
    var suggestedProductList: SuggestedProductList { get }
    func fetchAllProducts()
    func updateAllProducts()
}

protocol ListingRouterInput: AnyObject {
    var navigationController: UINavigationController! { get }
    func showAlert(with error: Error)
}

final class ListingPresenter {
    
    weak var view: ListingViewControllerInput!
    var interactor: ListingInteractorInput
    var router: ListingRouterInput
    
    init(view: ListingViewControllerInput!, interactor: ListingInteractorInput, router: ListingRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ListingPresenter: ListingViewControllerOutput {
    func viewWillAppear() {
        view.showLoading()
        interactor.updateAllProducts()
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        if section == 0 {
            return interactor.suggestedProductList.products.count
        } else {
            return interactor.productList.products.count
        }
    }
    
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter {
        if indexPath.section == 0 {
            let presenter = interactor.suggestedProductList.products[indexPath.item]
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        } else {
            let presenter = interactor.productList.products[indexPath.item]
            presenter.router = ProductCellRouter(navigationController: router.navigationController)
            return presenter
        }
    }
    
    func viewDidLoad() {
        view.showLoading()
        view.configureCollectionView()
        view.configureNavigationBar()
        view.configureSubviews()
        interactor.fetchAllProducts()
    }
    
    func didTapCell() {
        print("Handle Show Product Detail")
    }
}

extension ListingPresenter: ListingInteractorOutput {
    func didReceiveAllProducts() {
        view.reload()
        view.hideLoading()
    }
    
    func didFail(with error: any Error) {
        view.hideLoading()
        router.showAlert(with: error)
    }
}
