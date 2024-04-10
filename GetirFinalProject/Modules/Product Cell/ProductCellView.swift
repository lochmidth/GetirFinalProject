//
//  ProductCellView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

final class ProductCellView: UICollectionViewCell {
    //MARK: - Properties
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "shoppingCart")
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getirGray.cgColor
        iv.layer.cornerRadius = 16
        iv.setDimensions(height: 103.67, width: 103.67)
        return iv
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "₺0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .getirPurple
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private let attributeLabel: UILabel = {
       let label = UILabel()
        label.text = "Attribute"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureSubviews() {
        backgroundColor = .white
        let stack = UIStackView(arrangedSubviews: [imageView, priceLabel, productLabel, attributeLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalSpacing
        addSubview(stack)
        stack.fillSuperview()
        
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 200), body: {
    ProductCellView()
})
