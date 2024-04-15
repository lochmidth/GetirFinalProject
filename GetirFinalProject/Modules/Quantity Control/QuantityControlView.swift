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

protocol QuantitiyControlViewOutput: AnyObject {
    var cellPresenterDelegate: QuantityControlDelegate? { get set }
    func didLoadQuantityControl()
    func didTapPlus()
    func didTapMinus()
}



final class QuantityControlView: UIView {
    //MARK: - Properties
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.setDimensions(height: 25.6, width: 25.6)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusIcon"), for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.setDimensions(height: 25.6, width: 25.6)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .getirPurple
        label.setDimensions(height: 25.6, width: 25.6)
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let stack = UIStackView()
    
    private let stackOrientation: StackOrientation
    var presenter: QuantitiyControlViewOutput!
    
    //MARK: - Lifecycle
    
    init(presenter: QuantitiyControlViewOutput!, stackOrientation: StackOrientation) {
        self.presenter = presenter
        self.stackOrientation = stackOrientation
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        valueLabel.text = "\(count)"
        switch stackOrientation {
        case .vertical:
            updateStackVisibility(with: count)
        case .horizontal:
            maximizeStack()
        }
        if count == 1 {
            minusButton.setImage(UIImage(named: "trashIcon"), for: .normal)
        } else {
            minusButton.setImage(UIImage(named: "minusIcon"), for: .normal)
        }
    }
}
