//
//  RSWalletDetailViewController.swift
//  FinanceManager
//
//  Created by Kirill on 27.09.21.
//

import UIKit

class RSWalletDetailViewController: UIViewController, RSWalletDetailViewControllerProtocol {
    
    weak var viewModel: RSWalletDetailViewModel! {
        didSet {
            viewModel.controller = self
        }
    }
    
    @IBOutlet weak var walletName: UILabel!
    @IBOutlet weak var walletSum: UILabel!
    @IBOutlet weak var seeAllTransactionButton: RSButtonWithGradient!
    @IBOutlet weak var addTransactionButton: RSButtonWithGradient!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        viewModel.registerCells()
        
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateView() {
        guard let viewModel = self.viewModel else { return }
        walletName.text = viewModel.walletName
        walletSum.text = viewModel.walletTransactionsSum
        collectionView.reloadData()
    }
    
    @IBAction func walletListButtonDidPress(_ sender: Any) {
        viewModel.walletListButtonDidPress()
    }
    
    @IBAction func walletEditButtonDidPress(_ sender: Any) {
        viewModel.walletEditButtonDidPress()
    }
    
    @IBAction func seeAllButtonDidPress(_ sender: Any) {
        viewModel.seeAllTransationsButtonDidPress()
    }
    @IBAction func addTransactionButtonDidPress(_ sender: Any) {
        viewModel.addTransactionButtonDidPress()
    }

}
