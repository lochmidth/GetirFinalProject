//
//  BasketViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol BasketViewControllerOutput: AnyObject {
    func viewDidLoad()
    func didTapCheckout()
    func didTapTrashButton()
    func numberOfItemsInSection(_ section: Int) -> Int
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter
}

final class BasketViewController: UIViewController {
    //MARK: - Porperties
    
    var collectionView: UICollectionView!
    var presenter: BasketViewControllerOutput!
    
    private let footer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow()
        view.setHeight(110)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .getirPurple
        label.textAlignment = .center
        label.text = "₺1.500,00"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var checkoutContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .getirPurple
        view.layer.cornerRadius = 10
        let checkoutButton = UIButton(type: .system)
        checkoutButton.backgroundColor = .clear
        checkoutButton.setTitle("Siparişi Tamamla", for: .normal)
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(checkoutButton)
        checkoutButton.addTarget(self, action: #selector(didTapCheckout), for: .touchUpInside)
        let priceBackgroundView = UIView()
        priceBackgroundView.backgroundColor = .white
        priceBackgroundView.layer.cornerRadius = 10
        view.addSubview(priceBackgroundView)
        priceBackgroundView.addSubview(priceLabel)
        checkoutButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: priceBackgroundView.leftAnchor)
        priceBackgroundView.anchor(top: view.topAnchor, left: checkoutButton.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        priceBackgroundView.setWidth(self.view.frame.width / 3)
        priceLabel.center(inView: priceBackgroundView)
        view.addShadow()
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @objc func didTapTrashBarButton() {
        presenter.didTapTrashButton()
    }
    
    @objc func didTapCheckout() {
        presenter.didTapCheckout()
    }
    
    //MARK: - Helpers
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionNumber, _ in
            if sectionNumber == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(117.3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(117.3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28),
                                                       heightDimension: .absolute(176.67))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        return layout
    }
}

extension BasketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketCell", for: indexPath) as! ProductCell
        cell.layer.borderWidth = 0
        if indexPath.section == 0 {
            cell.orientation = .large
        } else {
            cell.orientation = .small
        }
        let cellPresenter = presenter.presenterForCell(at: indexPath)
        cell.reload(with: cellPresenter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SuggestedProductsHeader.reuseIdentifier, for: indexPath)
        return header
    }
}

extension BasketViewController: BasketViewControllerInput {
    func reload(withPrice priceText: String) {
        Task { @MainActor in
            collectionView.reloadData()
            priceLabel.text = priceText
        }
    }
    
    func configureNavigationbar() {
        let trashIcon = UIImageView(image: UIImage(named: "whiteTrashIcon"))
        let trashIconBarButton = UIBarButtonItem(customView: trashIcon)
        trashIcon.setDimensions(height: 18, width: 16.8)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTrashBarButton))
        trashIcon.addGestureRecognizer(tap)
        self.navigationItem.rightBarButtonItem = trashIconBarButton
        title = "Sepetim"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "BasketCell")
        collectionView.register(SuggestedProductsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SuggestedProductsHeader.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureSubviews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        view.addSubview(footer)
        footer.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        footer.addSubview(checkoutContainerView)
        checkoutContainerView.anchor(top: footer.topAnchor, left: view.leftAnchor, bottom: footer.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
}

final class SuggestedProductsHeader: UICollectionReusableView {
    static let reuseIdentifier = "SuggestedProductsHeaderView"
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Önerilen Ürünler"
        label.font = UIFont.systemFont(ofSize: 12)
        addSubview(label)
        label.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8, constant: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
