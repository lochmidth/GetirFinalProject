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
    func didTapPlus()
    func didTapMinus()
}

final class QuantityControlView: UIView {
    //MARK: - Properties
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.getirPurple, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .getirPurple
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let stack = UIStackView()
    
    private let stackOrientation: StackOrientation
    var presenter: QuantitiyControlViewOutput!
    
    private var count = 0 {
        didSet {
            valueLabel.text = "\(count)"
        }
    }
    
    //MARK: - Lifecycle
    
    init(stackOrientation: StackOrientation) {
        self.stackOrientation = stackOrientation
        super.init(frame: .zero)
        
        configureUI()
        minimizeStack()
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
    
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        configureOrientation()
        addShadow()
    }
    
    private func configureOrientation() {
        let views = [plusButton, valueLabel, minusButton]
        stack.distribution = .fillEqually
        switch stackOrientation {
        case .vertical:
            views.forEach { view in
                stack.addArrangedSubview(view)
            }
            stack.axis = .vertical
            stack.setDimensions(height: 76.8, width: 25.6)
        case .horizontal:
            views.reversed().forEach { view in
                stack.addArrangedSubview(view)
            }
            stack.axis = .horizontal
            stack.setDimensions(height: 48, width: 146)
        }
        addSubview(stack)
        stack.fillSuperview()
    }
    
    private func minimizeStack() {
        valueLabel.isHidden = true
        minusButton.isHidden = true
        stack.setDimensions(height: 25.6, width: 25.6)
    }
    
    private func maximizeStack() {
        valueLabel.isHidden = false
        minusButton.isHidden = false
        stack.setDimensions(height: 76.8, width: 25.6)
    }
}

extension QuantityControlView: QuantitiyControlViewInput {
    func increaseCount() {
        count += 1
        if count > 0 {
            maximizeStack()
        }
    }
    
    func decreaseCount() {
        count -= 1
        if count == 0 {
            minimizeStack()
        }
    }
}
