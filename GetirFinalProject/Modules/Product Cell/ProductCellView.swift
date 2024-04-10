//
//  ProductCellView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit
import Kingfisher

protocol ProductCellViewDelegate: AnyObject {
    func didTapCell()
}

final class ProductCellView: UICollectionViewCell {
    //MARK: - Properties
    
    weak var delegate: ProductCellViewDelegate?
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
//        iv.image = UIImage(named: "shoppingCart")
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getirGray.cgColor
        iv.layer.cornerRadius = 16
        iv.setDimensions(height: 103.67, width: 103.67)
        return iv
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
//        label.text = "₺0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .getirPurple
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
//        label.text = "Product Name"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private let attributeLabel: UILabel = {
       let label = UILabel()
//        label.text = "Attribute"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var stack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [imageView, priceLabel, productLabel, attributeLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        stack.isUserInteractionEnabled = true
        stack.addGestureRecognizer(gesture)
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func didTapCell() {
        delegate?.didTapCell()
    }
    
    //MARK: - Helpers
    
    private func configureSubviews() {
        backgroundColor = .white
        contentView.addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2)
    }
    
    private func setCellImage(with url: URL?) {
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
    
    func reload(with product: Product) {
        priceLabel.text = product.priceText
        productLabel.text = product.name
        attributeLabel.text = product.attribute
        setCellImage(with: product.imageURL)
        
    }
}
