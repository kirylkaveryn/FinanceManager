//
//  RSCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 26.09.21.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var parentCoordinator: CoordinatorProtocol? { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

protocol CoreDataProtocol {
    var coreDataManager: CoreDataManageProtocol { get }
}
