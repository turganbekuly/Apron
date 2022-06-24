//
//  SavedRecipes+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.06.2022.
//

import Foundation
import UIKit

extension SavedRecipesViewController: UICollectionViewDataSource {
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
            let cell: SavedRecipeCell = collectionView.dequeueReusableCell(for: indexPath)
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

extension SavedRecipesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            let vc = RecipePageBuilder(state: .initial(id: recipe.id, .saved)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
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
            guard let cell = cell as? SavedRecipeCell else { return }
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
                with: CommunityFilterCellViewModel(searchbarPlaceholder: "Поиск рецептов в избранном")
            )
        }
    }
}
