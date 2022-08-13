//
//  RSCurrencyListCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation
import UIKit

class RSCurrencyCoordinator: CoordinatorProtocol {
    
    var coreDataManager: CoreDataManager?
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    var currency: String?
    var currencyDidSet: ((String?) -> ())?
    var coordinatorDidResign: (() -> ())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RSCollectionViewController(nibName: nil, bundle: nil)
        let viewModel = RSCurrencyViewModel()
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
    }

}

extension RSCurrencyCoordinator: RSCurrencyCoordinatorProtocol {
    
    func backButtonDidPress() {
        navigationController.popViewController(animated: true)
        coordinatorDidResign?()
    }
    
    func updateCurrency(currency: String?) {
        guard let currency = currency else { return }
        self.currency = currency
        currencyDidSet?(currency)
    }
}
