//
//  QuantityControlRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class QuantityControlRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension QuantityControlRouter: QuantityControlRouterInput {
    
}
