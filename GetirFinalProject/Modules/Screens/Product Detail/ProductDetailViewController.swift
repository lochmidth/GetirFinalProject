//
//  ProductDetailViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 14.04.2024.
//

import UIKit
import Kingfisher

protocol ProductDetailViewControllerOutput: AnyObject {
    func viewDidLoad()
    func configureQuantityControl() -> QuantityControlView
    func didTapAddToCartButton()
}

final class ProductDetailViewController: UIViewController {
    //MARK: - Properties
    
    var presenter: ProductDetailViewControllerOutput!
    var isQuantityControlCreated = false
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 200, width: 200)
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .getirPurple
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
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
    
    private let footer: UIView = {
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
        button.addTarget(self, action: #selector(didTapAddToCartButton), for: .touchUpInside)
        return button
    }()
    
    var quantityControl: QuantityControlView?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @objc func didTapAddToCartButton() {
        presenter.didTapAddToCartButton()
    }
    
    //MARK: - Helpers
    
    private func setImage(with url: URL?) {
        let processor = RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}

extension ProductDetailViewController: ProductDetailViewControllerInput {
    func reload(with product: Product) {
        setImage(with: product.imageURL)
        priceLabel.text = product.priceText
        productLabel.text = product.name
        attributeLabel.text = product.attribute
    }
    
    func configureProductDetails(with product: Product) {
        view.backgroundColor = .white
        view.addSubview(footer)
        let stack = UIStackView(arrangedSubviews: [imageView, priceLabel, productLabel, attributeLabel, divider])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 16)
        footer.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configureFooterSubviews(count: Int) {
        if count == 0 {
            quantityControl?.removeFromSuperview()
            isQuantityControlCreated = false
            footer.addSubview(addToCartButton)
            addToCartButton.anchor(top: footer.topAnchor, left: view.leftAnchor, bottom: footer.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                   paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        } else {
            guard isQuantityControlCreated == false else { return }
            addToCartButton.removeFromSuperview()
            quantityControl = presenter.configureQuantityControl()
            guard let quantityControl else { return }
            isQuantityControlCreated = true
            footer.addSubview(quantityControl)
            quantityControl.center(inView: footer)
            quantityControl.setDimensions(height: 48, width: 144)
            quantityControl.configureUI()
        }
    }
    
    func configureNavigationBar() {
        title = "Ürün Detayı"
    }
}
