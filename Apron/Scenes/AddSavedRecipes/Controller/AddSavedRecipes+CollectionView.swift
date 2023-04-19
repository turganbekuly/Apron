//
//  AddSavedRecipes+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.06.2022.
//

import Foundation
import UIKit
import APRUIKit

extension AddSavedRecipesViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe:
            let cell: AddsavedRecipeCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .loading:
            let cell: MainCommunityEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension AddSavedRecipesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            if selectedRecipes.contains(recipe.id) {
                collectionView.deselectItem(at: indexPath, animated: false)
            } else {
                selectedRecipes.append(recipe.id)
            }
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            selectedRecipes.removeAll(where: { $0 == recipe.id })
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe, .loading:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 218)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? AddsavedRecipeCell else { return }
            cell.configure(with: SavedRecipeCellViewModel(image: recipe.imageURL, name: recipe.recipeName))
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section].section
        switch section {
        case .recipes:
            let view: SavedRecipeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = sections[section].section
        switch section {
        case .recipes:
            return CGSize(width: collectionView.bounds.width - 32, height: 65)
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String,
                               at indexPath: IndexPath) {
        let section = sections[indexPath.section].section
        switch section {
        case .recipes:
            guard let view = view as? SavedRecipeHeaderView else { return }
            view.delegate = self
            view.configure(
                with: CommunityFilterCellViewModel(searchbarPlaceholder: L10n.AddSavedRecipes.SearchFavoriteRecipes.title)
            )
        }
    }
}
