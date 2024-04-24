//
//  ListingViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

protocol ListingViewControllerOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItemsInSection(_ section: Int) -> Int
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter
}

final class ListingViewController: UIViewController {
    //MARK: - Properties
    
    var collectionView: UICollectionView!
    var presenter: ListingViewControllerOutput!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    //MARK: - Helpers
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.createFirstSectionLayout()
            } else {
                return self.createSecondSectionLayout()
            }
        }
        return layout
    }

    private func createFirstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .absolute(176.67))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func createSecondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(174.67))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self.view.frame.size.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: Constants.spacer, alignment: .topLeading)]
        return section
    }
}

//MARK: - UICollectionViewDataSource/Delegate

extension ListingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.productCellIdentifier, for: indexPath) as! ProductCell
        cell.orientation = .small
        let cellPresenter = presenter.presenterForCell(at: indexPath)
        cell.reload(with: cellPresenter)
        return cell
    }
}

extension ListingViewController: ListingViewControllerInput {
    func showLoading() {
        showLoader(true)
    }
    
    func hideLoading() {
        showLoader(false)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Constants.productCellIdentifier)
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
        Task { @MainActor in
            collectionView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        title = Constants.title
    }
}

extension ListingViewController {
    struct Constants {
        static let productCellIdentifier = "ProductCell"
        static let spacer = "spacer"
        static let title = "Ürünler"
    }
}
