//
//  RSColorThemeViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation
import UIKit


protocol RSCurrencyCoordinatorProtocol: CoordinatorProtocol {
    func backButtonDidPress()
    func updateCurrency(currency: String?)
}

protocol RSCurrencyViewModelTypeProtocol: AnyObject {
    var coordinator: RSCurrencyCoordinatorProtocol? { get set }
    var controller: RSCollectionViewControllerProtocol? { get set }
    var preferredCurrencyList: [String] { get set }
    var currency: String? { get set }
    
}

class RSCurrencyViewModel: NSObject, RSCurrencyViewModelTypeProtocol {
    var coordinator: RSCurrencyCoordinatorProtocol?
    weak var controller: RSCollectionViewControllerProtocol?
    var currency: String?
    var currencyList: [String]
    var preferredCurrencyList: [String]
    
    init(currencyList: [String] = Locale.commonISOCurrencyCodes, preferredCurrencyList: [String] = ["USD", "EUR", "BYN", "RUB"]) {
        self.currencyList = currencyList
        self.preferredCurrencyList = preferredCurrencyList
    }
}

extension RSCurrencyViewModel: RSCollectionViewViewModelTypeProtocol {
    
    func registerCells() {
        controller?.collectionView.register(UINib(nibName: "RSCurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RSCurrencyCollectionViewCell.reuseID)
        controller?.collectionView.register(UINib(nibName: "RSCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID)
    }
    
    // MARK: - CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return preferredCurrencyList.count
        default:
            return currencyList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSCurrencyCollectionViewCell.reuseID, for: indexPath) as! RSCurrencyCollectionViewCell
        let currencyCode = currencyList[indexPath.item]
        
        switch indexPath.section {
        case 0:
            cell.currency.text = preferredCurrencyList[indexPath.item]
            cell.currencyName.text = currencyNameByCode(code: preferredCurrencyList[indexPath.item])
        default:
            cell.currency.text = currencyCode.description
            cell.currencyName.text = currencyNameByCode(code: currencyCode)
        }
        return cell
    }

    // MARK: - CollectionView LayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let defaultCellSize = CGSize(width: UIScreen.main.bounds.width - 34, height: 75)

        switch indexPath.section {
        case 0:
            if preferredCurrencyList.isEmpty {
                return CGSize.zero
            } else {
                return defaultCellSize
            }
        default:
            return defaultCellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID, for: indexPath) as! RSCollectionViewHeader
            header.title.text = "Currency"
            header.backButtonDidPress = { [weak self] in
                self?.coordinator?.backButtonDidPress()
            }
            return header
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 115)
        default:
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 17, bottom: 30, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }

    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RSCurrencyCollectionViewCell else { return }
        guard let currencyText = cell.currency.text else { return }
        coordinator?.updateCurrency(currency: currencyText)
        UIView.animate(withDuration: 0.2) {
            cell.contentView.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.contentView.transform = .init(scaleX: 1, y: 1)
        }
    }
    
}

