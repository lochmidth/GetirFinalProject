//
//  ListingView.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

protocol ListingViewOutput: AnyObject {
    func didTapCell()
}

final class ListingView: UIView {
    //MARK: - Properties
    
    var collectionView: UICollectionView!
    weak var output: ListingViewOutput?
    var products = [Product]()
    var suggestedProducts = [Product]()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureSubviews() {
        backgroundColor = .systemGroupedBackground
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "productCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionNumber, _ in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.28), heightDimension: .absolute(168.67)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(168.67)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self.frame.size.height)), subitems: [item])
               let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: "spacer", alignment: .topLeading)]
                return section
            }
        }
        return layout
    }
}

//MARK: - UICollectionViewDataSource/Delegate

extension ListingView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return suggestedProducts.count
        }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCellView
        if indexPath.section == 0 {
            cell.reload(with: suggestedProducts[indexPath.item])
            return cell
        }
        cell.reload(with: products[indexPath.item])
        return cell
    }
}

extension ListingView: ProductCellViewOutput {
    func didTapCell() {
        output?.didTapCell()
    }
}

extension ListingView: listingViewInput {
    func reload(with products: ProductList, _ suggestedProducts: SuggestedProductList) {
        self.products = products.products
        self.suggestedProducts = suggestedProducts.products
        Task { @MainActor in
            collectionView.reloadData()
        }
    }
}
