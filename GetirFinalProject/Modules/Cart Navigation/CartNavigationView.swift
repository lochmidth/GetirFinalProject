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
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "BasketIcon")?.withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 24, width: 24)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getirPurple
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func toggleVisibility(with totalPrice: String) {
        if totalPrice == "₺0.00" {
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
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeCart), name: Notification.Name("DidCalculateTotalPrice"), object: nil)
    }
    
    func reload() {
        let totalPrice = CartService.shared.totalPrice
        UIView.transition(with: priceLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.priceLabel.text = totalPrice
            self.toggleVisibility(with: totalPrice)
        }
    }
}
