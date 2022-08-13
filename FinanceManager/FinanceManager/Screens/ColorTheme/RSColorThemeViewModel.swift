//
//  RSColorThemeViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation
import UIKit


protocol RSColorThemeCoordinatorProtocol: AnyObject {
    func backButtonDidPress()
    func colorThemeCellDidSelect(themeIndex: Int)
}

protocol RSColorThemeViewModelType: AnyObject {
    var coordinator: RSColorThemeCoordinatorProtocol? { get set }
    var images: [UIImage]? { get }
}

class RSColorThemeViewModel: NSObject, RSColorThemeViewModelType {
    weak var coordinator: RSColorThemeCoordinatorProtocol?
    weak var controller: RSCollectionViewControllerProtocol?
    let images: [UIImage]?
    var themeIndex: Int16?

    init(backgroundImages: [UIImage], themeIndex: Int16?) {
        self.images = backgroundImages
        self.themeIndex = themeIndex
    }
    
}

extension RSColorThemeViewModel: RSCollectionViewViewModelTypeProtocol {
    
    func registerCells() {
        controller?.collectionView.register(UINib(nibName: "RSColorThemeCell", bundle: nil), forCellWithReuseIdentifier: RSColorThemeCell.reuseID)
        controller?.collectionView.register(UINib(nibName: "RSCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID)
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.images else {
            return 0
        }
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSColorThemeCell.reuseID, for: indexPath) as! RSColorThemeCell
                if let images = self.images {
            cell.imageView.image = images[indexPath.item]
        }
                return cell
    }
    
    // MARK: - CollectionView LayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 34, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID, for: indexPath) as! RSCollectionViewHeader
            header.title.text = "Color themes"
            header.backButtonDidPress = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.backButtonDidPress()
            }
            
            return header
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 115)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 17, bottom: 30, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
 
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let themeImageIndex = Int(indexPath.item)
        RSApplicationCoordinator.backgroundImageView.changeImage(with: RSThemeImageViews[themeImageIndex])
        coordinator?.colorThemeCellDidSelect(themeIndex: themeImageIndex)

        let cell = collectionView.cellForItem(at: indexPath) as? RSColorThemeCell
        UIView.animate(withDuration: 0.2) {
            cell!.contentView.transform = .init(scaleX: 0.9, y: 0.9)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.contentView.transform = .init(scaleX: 1, y: 1)
        }
    }
    
}
