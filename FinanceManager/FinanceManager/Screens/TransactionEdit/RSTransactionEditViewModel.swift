//
//  RSTransactionEditViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

enum PostAlert {
    case nilValue
    case nullValue
    case nameNil
    case tooLongName
    case tooLongNote
}

protocol RSTransactionEditCoordinatorProtocol: CoordinatorProtocol {
    func backButtonPressed()
}

protocol RSTransactionEditViewControllerProtocol: AnyObject {
    var viewModel: RSTransactionEditViewModelType! { get set }
    var textFieldDidEdited: ((String?, String?, String?) -> ())? { get set }
    func goBackToTextField(alert: PostAlert)
}

protocol RSTransactionEditViewModelType: AnyObject {
    var coordinator: RSTransactionEditCoordinatorProtocol? { get set }
    var viewController: RSTransactionEditViewControllerProtocol? { get set }
    var coreDataManager: CoreDataManageProtocol { get set }
    
    var saveTransaction: ((String?, NSDecimalNumber?, String?) -> ())? { get set }
    var transactionEditMode: TransactionEditMode { get set }
    var wallet: Wallet { get set }
    var transaction: Transaction? { get set }
        
    var title: String { get set }
    var name: String { get set }
    var value: NSDecimalNumber? { get set }
    var note: String? { get set }
    var transactionState: SegmentControlState  { get set }
    
    func updateTextFieldsWhenDidEditing()
    func backButtonPressed()
    func segmentedControlAction(segmentControlState: SegmentControlState)
}

class RSTransactionEditViewModel: NSObject, RSTransactionEditViewModelType {
    
    var coordinator: RSTransactionEditCoordinatorProtocol?
    weak var viewController: RSTransactionEditViewControllerProtocol?
    var navigationController: UINavigationController
    var coreDataManager: CoreDataManageProtocol
    var transactionEditMode: TransactionEditMode
    var wallet: Wallet
    var transaction: Transaction?
    
    var saveTransaction: ((String?, NSDecimalNumber?, String?) -> ())?
    
    var title: String
    var name: String
    var value: NSDecimalNumber?
    var note: String?
    var transactionState: SegmentControlState = .outcome
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, wallet: Wallet, transactionEditMode: TransactionEditMode) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.transactionEditMode = transactionEditMode
        self.wallet = wallet
        switch transactionEditMode {
        case .new:
            self.title = "New transaction"
            self.name = ""
            self.value = 0
            self.transactionState = .outcome
        case .edit(let transaction):
            self.transaction = transaction
            self.title = "Edit transaction"
            self.name = transaction.name
            self.value = transaction.value
            self.note = transaction.note
            if transaction.value.intValue > 0 {
                transactionState = .income
            } else {
                transactionState = .outcome
            }
        }
    }

    func updateTextFieldsWhenDidEditing() {
        viewController?.textFieldDidEdited = { [weak self] title, change, note in
            guard let self = self else { return }
            
            self.name = title ?? ""
            self.note = note
            if change != nil && change?.isEmpty == false {
                switch self.transactionState {
                case .outcome:
                    self.value = NSDecimalNumber(string: change).multiplying(by: -1)
                case .income:
                    self.value = NSDecimalNumber(string: change)
                }
            } else {
                self.value = nil
            }
        }
    }

}


extension RSTransactionEditViewModel {
    func backButtonPressed() {
        let alert = UIAlertController(title: "Save changes?", message: nil, preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            if self.name.isEmpty {
                self.postAlert(alert: .nameNil)
                return
            }
            if self.name.count >= 20 {
                self.postAlert(alert: .tooLongName)
                return
            }
            if self.value == NSDecimalNumber.notANumber || self.value == nil {
                self.postAlert(alert: .nilValue)
                return
            }
            if self.value == 0 {
                self.postAlert(alert: .nullValue)
                return
            }
            if let note = self.note {
                if note.count >= 250 {
                    self.postAlert(alert: .tooLongNote)
                    return
                }
            }
            
            guard let value = self.value else { return }
            
            switch self.transactionEditMode {
            case .new:
                self.coreDataManager.createNewTransaction(forWallet: self.wallet,
                                                          name: self.name,
                                                          value: value,
                                                         date: Date(),
                                                         note: self.note)
            case .edit(_):
                self.transaction?.name = self.name
                self.transaction?.value = value
                self.transaction?.date = Date()
                self.transaction?.note = self.note
                self.coreDataManager.saveContext()
            }
            
            self.coordinator?.backButtonPressed()
        })
        
        let discardAction = UIAlertAction(title: "Discard changes", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.backButtonPressed()
        })
        discardAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(discardAction)
        alert.addAction(cancelAction)
        
        navigationController.present(alert, animated: true) {
            alert.removeFromParent()
        }
        
        self.coordinator?.backButtonPressed()
    }
    
    func postAlert(alert: PostAlert) {
        var alertTitle: String = ""
        switch alert {
        case .nilValue:
            alertTitle = "Enter the change of transaction"
        case .nullValue:
            alertTitle = "Transacrion change must not be 0"
        case .nameNil:
            alertTitle = "Enter the name of transaction"
        case .tooLongName:
            alertTitle = "Too long name"
        case .tooLongNote:
            alertTitle = "Too long note"
        }
        
        let transactionAlert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        transactionAlert.addAction(UIAlertAction(title: "Got it", style: .default))
        self.navigationController.present(transactionAlert, animated: true) {
            transactionAlert.removeFromParent()
        }
        
        viewController?.goBackToTextField(alert: alert)
    }
    
    func segmentedControlAction(segmentControlState: SegmentControlState) {
        transactionState = segmentControlState
    }
}

