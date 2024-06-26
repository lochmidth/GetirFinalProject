//
//  CartNavigationView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol CartNavigationViewOutput:AnyObject {
    func viewDidLoad()
    func didTapCart()
}

final class CartNavigationView: UIView {
    
    var presenter: CartNavigationViewOutput!
    let cartService: CartServiceProtocol
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.basketIcon)?.withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 24, width: 24)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getirPurple
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let whiteSection: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let graySection: UIView = {
        let view = UIView()
        view.backgroundColor = .getirGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    init(frame: CGRect, cartService: CartServiceProtocol = CartService.shared) {
        self.cartService = cartService
        super.init(frame: frame)
    }
    
    deinit {
        removeObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    private func toggleVisibility(with totalPrice: String) {
        if totalPrice == Constants.totalPrice {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
    }
    
    @objc func didChangeCart() {
        Task { @MainActor in
            reload()
        }
    }
    
    @objc func didTapCart() {
        presenter.didTapCart()
    }
}

extension CartNavigationView: CartNavigationViewInput {
    func configureNavigationView() {
        setDimensions(height: 34, width: 91)
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        addSubview(whiteSection)
        whiteSection.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        whiteSection.setWidth(34)
        addSubview(graySection)
        graySection.anchor(top: topAnchor, left: whiteSection.rightAnchor, bottom: bottomAnchor, right: rightAnchor)
        addSubview(imageView)
        imageView.centerY(inView: whiteSection, leftAnchor: leftAnchor, paddingLeft: 5)
        addSubview(priceLabel)
        priceLabel.centerY(inView: graySection, leftAnchor: graySection.leftAnchor, paddingLeft: 5)
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCart))
        addGestureRecognizer(tap)
    }
    
    func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeCart), name: .didCalculateTotalPrice, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .didCalculateTotalPrice, object: nil)
    }
    
    func reload() {
        let totalPrice = cartService.totalPrice
        UIView.transition(with: priceLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.priceLabel.text = totalPrice
            self.toggleVisibility(with: totalPrice)
        }
    }
}

extension CartNavigationView {
    struct Constants {
        static let basketIcon = "BasketIcon"
        static let totalPrice = "₺0.00"
        static let fatalError = "init(coder:) has not been implemented"
    }
}
