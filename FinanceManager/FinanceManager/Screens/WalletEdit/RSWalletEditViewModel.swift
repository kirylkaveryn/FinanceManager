//
//  RSWalletEditViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

struct DefaultWallet {
    static let currencyCode = "USD"
    static let currencySymbol = "$"
    static let walletName = ""
    static let themeIndex = 0
}
protocol RSWalletEditCoordinatorProtocol: AnyObject {
    func deleteButtonPressed()
    func backButtonPressed()
    func colorThemeButtonPressed()
    func currencyButtonPressed()
}

protocol RSWalletEditViewControllerProtocol: AnyObject {
    func updateView()
    func textFieldBecomeFirstResponder()
}

protocol RSWalletEditViewModelTypeProtocol: AnyObject {
    var coordinator: RSWalletEditCoordinatorProtocol? { get set }
    var viewController: RSWalletEditViewControllerProtocol? { get set }
    
    var wallet: Wallet? { get set }
    var titleLabel: String  { get set }
    var currencyLabel: String  { get set }
    var currencyCode: String  { get set }
    var walletName: String  { get set }
    var deleteButtonIsHidden: Bool  { get set }
    var themeIndex: Int { get set }
    
    func deleteButtonPressed()
    func backButtonPressed()
    func colorThemeButtonPressed()
    func currencyButtonPressed()
    func textFieldDidChange(title: String)
}

class RSWalletEditViewModel: NSObject, RSWalletEditViewModelTypeProtocol {
    
    internal var wallet: Wallet?
    weak var coordinator: RSWalletEditCoordinatorProtocol?
    weak var viewController: RSWalletEditViewControllerProtocol?
    var coreDataManager: CoreDataManageProtocol
    var navigationController: UINavigationController

    var titleLabel: String
    var currencyLabel: String
    var currencyCode: String
    var walletName: String
    var deleteButtonIsHidden = true
    var themeIndex: Int
    var walletEditMode: WalletEditMode
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, walletEditMode: WalletEditMode) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.walletEditMode = walletEditMode
        switch walletEditMode {
        case .new:
            self.titleLabel = "Add new wallet"
            self.currencyCode = DefaultWallet.currencyCode
            self.walletName = DefaultWallet.walletName
            self.currencyLabel = currencyLabelWithSpace(currency: DefaultWallet.currencyCode)
            self.deleteButtonIsHidden = true
            self.themeIndex = 0
        case .edit(let wallet):
            self.titleLabel = "Edit wallet"
            self.wallet = wallet
            self.walletName = wallet.name
            self.themeIndex = Int(wallet.themeIndex)
            self.currencyCode = wallet.currency
            self.currencyLabel = currencyLabelWithSpace(currency: wallet.currency)
            self.deleteButtonIsHidden = false
        }
    }
    
    func updateWalletThemeImage(themeIndex: Int) {
        self.themeIndex = themeIndex
        updateView()
    }
    
    func updateWalletCurrency(currency: String) {
        self.currencyCode = currency
        updateView()
    }
    
    func updateWalletTitle(title: String) {
        self.walletName = title
        updateView()
    }
    
    func updateView() {
        currencyLabel = currencyLabelWithSpace(currency: currencyCode)
        viewController?.updateView()
    }
    
    func updateWallet() {
        wallet?.name = walletName
        wallet?.currency = currencyCode
        wallet?.themeIndex = Int16(themeIndex)
    }

}

extension RSWalletEditViewModel: RSWalletEditCoordinatorProtocol {
    func deleteButtonPressed() {
        let alert = UIAlertController(title: "Delete wallet?", message: nil, preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let wallet = self.wallet else { return }
            self.coreDataManager.deleteWallet(wallet: wallet)
            self.coordinator?.deleteButtonPressed()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(delete)
        alert.addAction(cancelAction)
        
        UserDefaults.standard.set(nil, forKey: rsDefaultsCurrentWallet)
        
        navigationController.present(alert, animated: true) {
            alert.removeFromParent()
        }
    }
    
    func backButtonPressed() {
        let alert = UIAlertController(title: "Save changes?", message: nil, preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            
            if self.walletName.isEmpty {
                self.viewController?.textFieldBecomeFirstResponder()
                return
            }
            
            if self.coreDataManager.fetchData().contains(where: { wallet in
                if wallet.name == self.walletName && self.walletName != self.wallet?.name {
                    return true
                } else {
                    return false
                }
                
            }) {
                let alert = UIAlertController(title: "Wallet name already exists", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
                    self.viewController?.textFieldBecomeFirstResponder()
                }))
                self.navigationController.present(alert, animated: true) {
                    alert.removeFromParent()
                }
                return
            }
            
            switch self.walletEditMode {
            case .new:
                self.coreDataManager.createNewWallet(name: self.walletName,
                                                     currency: self.currencyCode,
                                                     themeIndex: self.themeIndex)
            case .edit(_):
                self.updateWallet()
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
    }
    
    func colorThemeButtonPressed() {
        coordinator?.colorThemeButtonPressed()
    }
    
    func currencyButtonPressed() {
        coordinator?.currencyButtonPressed()
    }
    
    func textFieldDidChange(title: String) {
        if title.count > 20 {
            let alert = UIAlertController(title: "Wallet name must not exceed 20 letters", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.navigationController.present(alert, animated: true) {
                alert.removeFromParent()
            }
            walletName = title
            walletName.removeLast()
        } else {
            walletName = title
        }
        updateView()
    }
}
