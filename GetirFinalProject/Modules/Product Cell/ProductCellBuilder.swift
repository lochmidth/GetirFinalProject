//
//  ProductCellBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class ProductCellBuilder {
    func build(using collectionView: UICollectionView, navigationController: UINavigationController, indexPath: IndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as! ProductCell
        let quantityControlBuilder = QuantityControlBuilder()
        let router = ProductCellRouter(navigationController: navigationController, quantityControlBuilder: quantityControlBuilder)
        let presenter = ProductCellPresenter(view: cell, router: router)
        cell.presenter = presenter
        return cell
    }
}
