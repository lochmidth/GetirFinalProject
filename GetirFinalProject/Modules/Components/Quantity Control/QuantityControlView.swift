//
//  QuantitiyControlView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import UIKit

enum StackOrientation {
    case vertical
    case horizontal
}

protocol QuantityControlViewOutput: AnyObject {
    var cellPresenterDelegate: QuantityControlDelegate? { get set }
    var interactor: QuantityControlInteractorInput { get set }
    func didLoadQuantityControl()
    func didTapPlus()
    func didTapMinus()
}

final class QuantityControlView: UIView {
    //MARK: - Properties
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.plusIcon), for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.setDimensions(height: 25.6, width: 25.6)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.minusIcon), for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.setDimensions(height: 25.6, width: 25.6)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .getirPurple
        label.setDimensions(height: 25.6, width: 25.6)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let stack = UIStackView()
    
    private let stackOrientation: StackOrientation
    var presenter: QuantityControlViewOutput!
    
    //MARK: - Lifecycle
    
    init(presenter: QuantityControlViewOutput!, stackOrientation: StackOrientation) {
        self.presenter = presenter
        self.stackOrientation = stackOrientation
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    //MARK: - Actions
    
    @objc func minusButtonTapped() {
        presenter.didTapMinus()
    }
    
    @objc func plusButtonTapped() {
        presenter.didTapPlus()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        presenter.didLoadQuantityControl()
    }
    
    private func minimizeStack() {
        valueLabel.isHidden = true
        minusButton.isHidden = true
    }
    
    private func maximizeStack() {
        valueLabel.isHidden = false
        minusButton.isHidden = false
    }
    
    private func updateStackVisibility(with count: Int) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            count > 0 ? self.maximizeStack() : self.minimizeStack()
        }
    }
}

extension QuantityControlView: QuantitiyControlViewInput {
    func enableButtons(_ bool: Bool) {
        minusButton.isEnabled = bool
        plusButton.isEnabled = bool
    }
    
    func configureStackOrientation() {
        guard stack.arrangedSubviews.isEmpty else { return }
        let views = [plusButton, valueLabel, minusButton]
        stack.distribution = .fillEqually
        stack.alignment = .fill
        switch stackOrientation {
        case .vertical:
            views.forEach { view in
                stack.addArrangedSubview(view)
            }
            stack.axis = .vertical
        case .horizontal:
            views.reversed().forEach { view in
                stack.addArrangedSubview(view)
            }
            stack.axis = .horizontal
        }
        addSubview(stack)
        stack.fillSuperview()
        addShadow()
    }
    
    func updateWithCount(_ count: Int) {
        Task { @MainActor in
            valueLabel.text = "\(count)"
        }
        switch stackOrientation {
        case .vertical:
            updateStackVisibility(with: count)
        case .horizontal:
            maximizeStack()
        }
        if count == 1 {
            minusButton.setImage(UIImage(named: Constants.trashIcon), for: .normal)
        } else {
            minusButton.setImage(UIImage(named: Constants.minusIcon), for: .normal)
        }
    }
}

extension QuantityControlView {
    struct Constants {
        static let plusIcon = "plusIcon"
        static let minusIcon = "minusIcon"
        static let trashIcon = "trashIcon"
        static let fatalError = "init(coder:) has not been implemented"
    }
}
