//
//  ProductDetailViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 14.04.2024.
//

import UIKit

protocol ProductDetailViewControllerOutput: AnyObject {
    func viewDidLoad()
}

final class ProductDetailViewController: UIViewController {
    //MARK: - Properties
    
    var presenter: ProductDetailViewControllerOutput!
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "shoppingCart")
        iv.setDimensions(height: 200, width: 200)
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺0,00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .getirPurple
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Product Name"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.text = "Attribute"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .getirPurple
        view.alpha = 0.2
        view.setDimensions(height: 0.5, width: self.view.frame.width)
        return view
    }()
    
    private lazy var footer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow()
        view.setHeight(110)
        return view
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .getirPurple
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var quantityControl: QuantityControlView?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        configureProductDetails()
        configureFooter(count: 0)
    }
    
    //MARK: - Helpers
    
    private func configureProductDetails() {
        view.backgroundColor = .white
        let stack = UIStackView(arrangedSubviews: [imageView, priceLabel, productLabel, attributeLabel, divider])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 16)
    }
    
    private func configureFooter(count: Int) {
        view.addSubview(footer)
        footer.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        if count == 0 {
            footer.addSubview(addToCartButton)
            addToCartButton.anchor(top: footer.topAnchor, left: view.leftAnchor, bottom: footer.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                   paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        } else {
            let quantityControlPresenter = QuantityControlPresenter(interactor: QuantityControlInteractor())
            let quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .horizontal)
            quantityControlPresenter.view = quantityControl
            footer.addSubview(quantityControl)
            quantityControl.center(inView: footer)
            quantityControl.setDimensions(height: 48, width: 144)
            quantityControl.configureUI()
        }
    }
    
    private func setTitle() {
        title = "Ürün Detayı"
    }
}

extension ProductDetailViewController: ProductDetailViewControllerInput {
    
}
