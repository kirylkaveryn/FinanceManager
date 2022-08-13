//
//  RSTransactionDetailViewController.swift
//  FinanceManager
//
//  Created by Kirill on 29.09.21.
//

import UIKit

class RSTransactionDetailViewController: UIViewController, RSTransactionDetailViewControllerProtocol {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var note: UILabel!
    
    weak var viewModel: RSTransactionDetailViewModelType! {
        didSet {
            viewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let viewModel = self.viewModel else { return }
        name.text = viewModel.name
        date.text = viewModel.date
        value.text = viewModel.value
        switch viewModel.transactionState {
        case .income:
            value.textColor = .rsCeladon
        case .outcome:
            value.textColor = .rsAmaranthRed
        }
        note.text = viewModel.note
    }
    
    @IBAction func backButtonDidPress(_ sender: Any) {
        viewModel.backButtonDidPress()
    }
    @IBAction func editTransactionButtonDidPress(_ sender: Any) {
        viewModel.transactionEditButtonDidPress()
    }
    @IBAction func deleteButtonDidPress(_ sender: Any) {
        viewModel.transactionDeleteButtonDidPress()
    }

}
