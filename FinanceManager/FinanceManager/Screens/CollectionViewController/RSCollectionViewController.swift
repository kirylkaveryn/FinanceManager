//
//  RSCollectionViewController.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit

protocol RSCollectionViewViewModelTypeProtocol: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var controller: RSCollectionViewControllerProtocol? { get set }
    func registerCells()
}

protocol RSCollectionViewControllerProtocol: AnyObject {
    var collectionView: UICollectionView! { get set }
    var viewModel: RSCollectionViewViewModelTypeProtocol! { get set }
}

class RSCollectionViewController: UIViewController, RSCollectionViewControllerProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: RSCollectionViewViewModelTypeProtocol! {
        didSet {
            viewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        viewModel.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.setContentOffset(CGPoint(x: 0, y: -44), animated: true)
    }
      
}
