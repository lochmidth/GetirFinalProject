//
//  BasketViewController.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol BasketViewControllerOutput: AnyObject {
    
}

final class BasketViewController: UIViewController {
    //MARK: - Porperties
    
    var collectionView: UICollectionView!
    var presenter: BasketViewControllerOutput!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    
}

extension BasketViewController: BasketViewControllerInput {
    
}
