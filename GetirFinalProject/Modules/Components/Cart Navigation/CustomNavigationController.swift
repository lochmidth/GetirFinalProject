//
//  CustomNavigationController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    let cartNavigationBuilder: CartNavigationBuilder
    let listingBuilder: ListingBuilder
    
    init(rootViewController: UIViewController, cartNavigationBuilder: CartNavigationBuilder = CartNavigationBuilder(), listingBuilder: ListingBuilder = ListingBuilder()) {
        self.cartNavigationBuilder = cartNavigationBuilder
        self.listingBuilder = listingBuilder
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationControllerProperties()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        configureNavigationControllerProperties()
        configureRightNavigationItem(viewController)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        super.popToViewController(viewController, animated: true)
    }
    
    private func configureNavigationControllerProperties() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .getirPurple
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationBar.scrollEdgeAppearance = apperance
        navigationBar.standardAppearance = apperance
    }
    
    private func configureRightNavigationItem(_ viewController: UIViewController) {
        if !(viewController is BasketViewController) {
            let rightView = cartNavigationBuilder.build(with: self)
            let rightBarButtonItem = UIBarButtonItem(customView: rightView)
            viewController.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
