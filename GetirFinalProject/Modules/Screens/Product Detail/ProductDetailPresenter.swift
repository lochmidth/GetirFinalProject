//
//  ProductDetailPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import Foundation

protocol ProductDetailViewControllerInput: AnyObject {
    func configureProductDetails(with product: Product)
    func configureFooterSubviews(count: Int)
    func setTitle()
}

protocol ProductDetailInteractorInput: AnyObject {
    var product: Product { get set }
    func increaseCount()
}

protocol ProductDetailRouterInput: AnyObject {
    
}

final class ProductDetailPresenter {
    
    weak var view: ProductDetailViewControllerInput!
    var interactor: ProductDetailInteractorInput
    var router: ProductDetailRouterInput
    let quantityControlBuilder: QuantityControlBuilder
    var quantityControlPresenter: QuantityControlPresenter?
    var cellPresenter: ProductCellPresenter
    
    init(view: ProductDetailViewControllerInput!, interactor: ProductDetailInteractorInput, router: ProductDetailRouterInput, cellPresenter: ProductCellPresenter, quantityControlBuilder: QuantityControlBuilder = QuantityControlBuilder()) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.cellPresenter = cellPresenter
        self.quantityControlBuilder = quantityControlBuilder
    }
}

extension ProductDetailPresenter: ProductDetailViewControllerOutput {
    func configureQuantityControl() -> QuantityControlView {
        self.quantityControlPresenter = quantityControlBuilder.build(with: interactor.product)
        let quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .horizontal)
        quantityControlPresenter?.view = quantityControl
        quantityControlPresenter?.cellPresenterDelegate = cellPresenter
        quantityControlPresenter?.productDetailDelegate = self
        quantityControl.presenter = quantityControlPresenter
        return quantityControl
    }
    
    func didTapAddToCartButton() {
//        interactor.increaseCount()
        let count = 1
//        quantityControlPresenter?.interactor.product.quantity = count
        didIncreaseCountForProduct(count)
        quantityControlPresenter?.didTapPlus()
    }
    
    func viewDidLoad() {
        view.configureProductDetails(with: interactor.product)
        view.configureFooterSubviews(count: interactor.product.quantity)
        view.setTitle()
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutput {
    func didIncreaseCountForProduct(_ count: Int) {
        view.configureFooterSubviews(count: count)
//        cellPresenter.product.quantity = count
        cellPresenter.didQuantityChange(count)
    }
}

extension ProductDetailPresenter: ProductDetailDelegate {
    func didQuantityChange(_ count: Int) {
        cellPresenter.product.quantity = count
        view.configureFooterSubviews(count: count)
    }
}