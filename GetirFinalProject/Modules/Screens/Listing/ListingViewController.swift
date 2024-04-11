//
//  ListingViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

protocol ListingViewControllerOutput: AnyObject {
    func viewDidLoad()
    func didTapCell()
}

protocol listingViewInput: AnyObject {
    func reload(with products: ProductList, _ suggestedProducts: SuggestedProductList)
}

final class ListingViewController: UIViewController {
    //MARK: - Properties
    
    var presenter: ListingViewControllerOutput!
    var input: listingViewInput!
    let listingView: ListingView
    
    //MARK: - Lifecycle
    
    init(listingView: ListingView) {
        self.listingView = listingView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func loadView() {
        view = listingView
        listingView.output = self
    }
    
    //MARK: - Helpers
}

extension ListingViewController: ListingViewOutput {
    func didTapCell() {
        presenter.didTapCell()
    }
}

extension ListingViewController: ListingViewControllerInput {
    func reload(with products: ProductList, _ suggestedProducts: SuggestedProductList) {
        input.reload(with: products, suggestedProducts)
    }
    
    func configureNavigationBar() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .getirPurple
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.standardAppearance = apperance
        title = "Ürünler"
    }
}
