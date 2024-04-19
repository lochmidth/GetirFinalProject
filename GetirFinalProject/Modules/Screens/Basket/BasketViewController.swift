//
//  BasketViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol BasketViewControllerOutput: AnyObject {
    func viewDidLoad()
    func numberOfItemsInSection(_ section: Int) -> Int
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter
}

final class BasketViewController: UIViewController {
    //MARK: - Porperties
    
    var collectionView: UICollectionView!
    var presenter: BasketViewControllerOutput!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionNumber, _ in
            if sectionNumber == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(117.3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                //  item.contentInsets = commonInsets
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
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        return layout
    }
    
    private func reloadData() {
        Task { @MainActor in
            collectionView.reloadData()
        }
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
        cell.orientation = .large
        let cellPresenter = presenter.presenterForCell(at: indexPath)
        cell.reload(with: cellPresenter)
        cell.backgroundColor = .red
        return cell
    }
}

extension BasketViewController: BasketViewControllerInput {
    func configureNavigationbar() {
        title = "Sepetim"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "BasketCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureSubviews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func reload() {
        reloadData()
    }
    
    
}
