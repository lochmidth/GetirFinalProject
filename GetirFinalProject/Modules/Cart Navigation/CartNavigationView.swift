//
//  CartNavigationView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class CartNavigationView: UIView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "BasketIcon")?.withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 24, width: 24)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺65,30"
        label.textColor = .getirPurple
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .left
        return label
    }()
    
    private let whiteSection: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let graySection: UIView = {
        let view = UIView()
        view.backgroundColor = .getirGray
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureNavigationView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavigationView() {
        setDimensions(height: 34, width: 91)
        backgroundColor = .clear
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
}
