//
//  ProductCellView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit
import Kingfisher

enum CellOrientation {
    case small
    case large
}

protocol ProductCellViewOutput: AnyObject {
    var quantityControlPresenter: QuantityControlPresenter? { get set }
    func didTapCell()
    func didLoadCell()
}

final class ProductCell: UICollectionViewCell {
    //MARK: - Properties
    
    var orientation: CellOrientation!
    var presenter: ProductCellViewOutput!
    
    private lazy var imageView: UIImageView = {
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
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    var quantityControl: QuantityControlView?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toggleImageViewBorder(0)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    //MARK: - Actions
    
    @objc func didTapCell() {
        presenter.didTapCell()
    }
    
    //MARK: - Helpers
    
    func reload(with presenter: ProductCellPresenter) {
        self.presenter = presenter
        presenter.view = self
        Task { @MainActor in
            presenter.didLoadCell()
        }
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
    
    private func toggleImageViewBorder(_ count: Int) {
        let animation = CABasicAnimation(keyPath: Constants.keyPath)
        animation.fromValue = imageView.layer.borderColor
        animation.toValue = (count > 0) ? UIColor.getirPurple.cgColor : UIColor.getirGray.cgColor
        animation.duration = 0.5
        imageView.layer.add(animation, forKey: Constants.keyPath)
        imageView.layer.borderColor = (count > 0) ? UIColor.getirPurple.cgColor : UIColor.getirGray.cgColor
    }
}

extension ProductCell: ProductCellViewInput {
    func configureStack() {
        backgroundColor = .white
        switch orientation {
        case .small:
            let views = [priceLabel, productLabel, attributeLabel]
            views.forEach { stack.addArrangedSubview($0) }
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(gesture)
            contentView.addSubview(imageView)
            imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 2, paddingLeft: 2, paddingRight: 2)
            contentView.addSubview(stack)
            stack.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                         paddingTop: 2, paddingLeft: 2, paddingRight: 2)
        case .large:
            let views = [productLabel, attributeLabel, priceLabel]
            views.forEach { stack.addArrangedSubview($0) }
            layer.borderColor = UIColor.getirGray.cgColor
            layer.borderWidth = 1
            imageView.isUserInteractionEnabled = false
            let horizontalStack = UIStackView(arrangedSubviews: [imageView, stack])
            horizontalStack.spacing = 8
            contentView.addSubview(horizontalStack)
            horizontalStack.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 8)
        default:
            break
        }
    }
    
    func update(with product: Product) {
        Task { @MainActor in
            priceLabel.text = product.priceText
            productLabel.text = product.name
            attributeLabel.text = product.attribute
            setCellImage(with: product.imageURL)
        }
    }
    
    func updateWithCount(_ count: Int) {
        if orientation == .small {
            toggleImageViewBorder(count)
        }
        quantityControl?.updateWithCount(count)
    }
    
    func configureQuantityControl(with count: Int) {
        switch orientation {
        case .small:
            // TODO: - QuantityControlüView kalıcak sadece presneter koy relaodla
            quantityControl?.removeFromSuperview()
            let quantityControlPresenter = presenter.quantityControlPresenter
            quantityControlPresenter?.interactor.product.quantity = count
            quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .vertical)
            guard let quantityControl else { return }
            quantityControlPresenter?.view = quantityControl
            contentView.addSubview(quantityControl)
            quantityControl.anchor(top: topAnchor, right: rightAnchor,
                                   paddingTop: -5, paddingRight: -5)
            quantityControl.configureUI() // TODO: - reload oarlak değiştir
        case .large:
            quantityControl?.removeFromSuperview()
            let quantityControlPresenter = presenter.quantityControlPresenter
            quantityControlPresenter?.interactor.product.quantity = count
            quantityControl = QuantityControlView(presenter: quantityControlPresenter, stackOrientation: .horizontal)
            guard let quantityControl else { return }
            quantityControl.setDimensions(height: 26, width: 78)
            quantityControlPresenter?.view = quantityControl
            contentView.addSubview(quantityControl)
            quantityControl.centerY(inView: self)
            quantityControl.anchor(left: stack.rightAnchor, right: rightAnchor,
                                   paddingLeft: 12, paddingRight: 16)
            quantityControl.configureUI()
        default:
            break
        }
    }
}

extension ProductCell {
    struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
        static let keyPath = "borderColor"
    }
}
