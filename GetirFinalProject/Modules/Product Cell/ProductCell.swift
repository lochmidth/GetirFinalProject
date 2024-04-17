//
//  ProductCellView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit
import Kingfisher

protocol ProductCellViewOutput: AnyObject {
    var quantityControlPresenter: QuantityControlPresenter? { get set }
    func didTapCell()
    func didLoadCell()
}

final class ProductCell: UICollectionViewCell {
    //MARK: - Properties
    
    var presenter: ProductCellViewOutput!
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.getirGray.cgColor
        iv.layer.cornerRadius = 16
        iv.setDimensions(height: 103.67, width: 103.67)
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .getirPurple
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, priceLabel, productLabel, attributeLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        stack.isUserInteractionEnabled = true
        stack.addGestureRecognizer(gesture)
        return stack
    }()
    
    var quantityControl: QuantityControlView?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func didTapCell() {
        presenter.didTapCell()
    }
    
    //MARK: - Helpers
    
    func reload(with presenter: ProductCellPresenter) {
        self.presenter = presenter
        presenter.view = self
        presenter.didLoadCell()
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
}

extension ProductCell: ProductCellViewInput {
    func update(with product: Product) {
        priceLabel.text = product.priceText
        productLabel.text = product.name
        attributeLabel.text = product.attribute
        setCellImage(with: product.imageURL)
    }
    
    func updateWithCount(_ count: Int) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = imageView.layer.borderColor
        animation.toValue = (count > 0) ? UIColor.getirPurple.cgColor : UIColor.getirGray.cgColor
        animation.duration = 0.5
        imageView.layer.add(animation, forKey: "borderColor")
        imageView.layer.borderColor = (count > 0) ? UIColor.getirPurple.cgColor : UIColor.getirGray.cgColor
        quantityControl?.updateWithCount(count)
    }
    
    func configureQuantityControl(with count: Int) {
        // TODO: - QuantityControlüView kalıcak sadece presneter koy relaodla
        quantityControl?.removeFromSuperview()
        let quantityControlPresenter = presenter.quantityControlPresenter
        quantityControlPresenter?.interactor.product.quantity = count
        quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .vertical)
        guard let quantityControl else { return }
        quantityControlPresenter?.view = quantityControl
        stack.addSubview(quantityControl)
        quantityControl.anchor(top: topAnchor, right: rightAnchor, paddingTop: -5, paddingRight: -5)
        quantityControl.configureUI() // TODO: - reload oarlak değiştir
    }
    
    func configureStack() {
        backgroundColor = .white
        contentView.addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2)
    }
}
