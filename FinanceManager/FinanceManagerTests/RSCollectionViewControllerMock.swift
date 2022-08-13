//
//  RSCollectionViewControllerMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSCollectionViewControllerMock: RSCollectionViewControllerProtocol {
    var collectionView: UICollectionView!
    
    var viewModel: RSCollectionViewViewModelTypeProtocol!
    
    init() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewLayout())
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}
