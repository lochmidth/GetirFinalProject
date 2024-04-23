//
//  ProductDetailPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import Foundation

protocol ProductDetailViewControllerInput: AnyObject {
    var quantityControl: QuantityControlView? { get set }
    func configureProductDetails(with product: Product)
    func reload(with product: Product)
    func configureFooterSubviews(count: Int)
    func configureNavigationBar()
    func showLoading()
    func hideLoading()
}

protocol ProductDetailInteractorInput: AnyObject {
    var product: Product { get set }
    func updateProduct()
}

final class ProductDetailPresenter {
    weak var view: ProductDetailViewControllerInput!
    var interactor: ProductDetailInteractorInput
    let quantityControlBuilder: QuantityControlBuilder
    var quantityControlPresenter: QuantityControlPresenter?
    
    init(view: ProductDetailViewControllerInput!, interactor: ProductDetailInteractorInput, quantityControlBuilder: QuantityControlBuilder = QuantityControlBuilder()) {
        self.view = view
        self.interactor = interactor
        self.quantityControlBuilder = quantityControlBuilder
    }
}

extension ProductDetailPresenter: ProductDetailViewControllerOutput {
    func viewWillAppear() {
        view.showLoading()
        interactor.updateProduct()
        view.quantityControl?.presenter.interactor.product = interactor.product
        view.quantityControl?.configureUI()
        view.hideLoading()
    }
    
    func viewDidLoad() {
        view.showLoading()
        view.configureProductDetails(with: interactor.product)
        view.reload(with: interactor.product)
        view.configureFooterSubviews(count: interactor.product.quantity)
        view.configureNavigationBar()
        view.hideLoading()
    }
    
    func configureQuantityControl() -> QuantityControlView {
        self.quantityControlPresenter = quantityControlBuilder.build(with: interactor.product)
        let quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .horizontal)
        quantityControlPresenter?.view = quantityControl
        quantityControlPresenter?.productDetailDelegate = self
        quantityControl.presenter = quantityControlPresenter
        return quantityControl
    }
    
    func didTapAddToCartButton() {
        let count = 1
        didIncreaseCountForProduct(count)
        quantityControlPresenter?.didTapPlus()
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutput {
    func didUpdateProduct() {
        view.reload(with: interactor.product)
        view.hideLoading()
    }
    
    func didIncreaseCountForProduct(_ count: Int) {
        view.configureFooterSubviews(count: count)
        view.hideLoading()
    }
}

extension ProductDetailPresenter: ProductDetailDelegate {
    func didQuantityChange(_ count: Int) {
        view.configureFooterSubviews(count: count)
        view.hideLoading()
    }
}
