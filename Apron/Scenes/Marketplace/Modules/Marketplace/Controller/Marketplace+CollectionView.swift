//
//  Marketplace+CollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 28.10.2023.
//

import Foundation
import UIKit
import APRUIKit
import PanModal

extension MarketplaceViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .item:
            let cell: MarketplaceItemCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .loading:
            let cell: MainCommunityEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .empty:
            let cell: EmptyListCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MarketplaceViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .item(item):
            let vc = MarketplaceItemDescriptionViewController(with: item)
            DispatchQueue.main.async {
                self.navigationController?.presentPanModal(vc)
            }
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .item, .loading:
            let itemWidth = (collectionView.bounds.width / 2) - 24
            return CGSize(
                width: itemWidth,
                height: itemWidth * 1.65
            )
        case .empty:
            return CGSize(width: collectionView.bounds.width, height: 230)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .item(item):
            guard let cell = cell as? MarketplaceItemCell else { return }
            cell.configure(with: item)
        case .empty:
            guard let cell = cell as? EmptyListCollectionCell else { return }
            cell.configure(
                with: L10n.SavedRecipes.AddFavoriteRecipes.title,
                image: APRAssets.savedRecipePlaceholder.image
            )
        default:
            break
        }
    }

//    public func collectionView(_ collectionView: UICollectionView,
//                               viewForSupplementaryElementOfKind kind: String,
//                               at indexPath: IndexPath) -> UICollectionReusableView {
//        let section = sections[indexPath.section].section
//        switch section {
//        case .recipes:
//            let view: SavedRecipeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
//            return view
//        }
//    }
//
//    public func collectionView(_ collectionView: UICollectionView,
//                               layout collectionViewLayout: UICollectionViewLayout,
//                               referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let section = sections[section].section
//        switch section {
//        case .recipes:
//            return CGSize(width: collectionView.bounds.width - 32, height: 65)
//        }
//    }
//
//    public func collectionView(_ collectionView: UICollectionView,
//                               willDisplaySupplementaryView view: UICollectionReusableView,
//                               forElementKind elementKind: String,
//                               at indexPath: IndexPath) {
//        let section = sections[indexPath.section].section
//        switch section {
//        case .recipes:
//            guard let view = view as? SavedRecipeHeaderView else { return }
//            view.delegate = self
//            view.configure(
//                with: CommunityFilterCellViewModel(searchbarPlaceholder: "Поиск рецептов в избранном")
//            )
//        }
//    }
}

