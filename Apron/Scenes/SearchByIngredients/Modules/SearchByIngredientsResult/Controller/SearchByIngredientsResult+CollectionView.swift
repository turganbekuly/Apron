//
//  SearchByIngredientsResult+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Foundation
import UIKit
import APRUIKit

extension SearchByIngredientsResultViewController: UICollectionViewDataSource {
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
            let cell: SBIResultCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
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

extension SearchByIngredientsResultViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            let vc = RecipePageBuilder(state: .initial(id: recipe.id, .searchByIngredients)).build()
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
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 240)
        case .empty:
            return CGSize(width: collectionView.bounds.width, height: 230)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? SBIResultCollectionCell else { return }
            cell.configure(with: recipe)
        case .empty:
            guard let cell = cell as? EmptyListCollectionCell else { return }
            cell.configure(
                with: L10n.SavedRecipes.AddFavoriteRecipes.title,
                image: APRAssets.savedRecipePlaceholder.image
            )
        case .loading:
            guard let cell = cell as? MainCommunityEmptyCollectionCell else { return }
            cell.startAnimation()
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section].section
        switch section {
        case .recipes:
            let view: SearchByIngredientsResultHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = sections[section].section
        switch section {
        case .recipes:
            return CGSize(width: collectionView.bounds.width, height: 70)
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String,
                               at indexPath: IndexPath) {
        let section = sections[indexPath.section].section
        switch section {
        case let .recipes(header):
            guard let view = view as? SearchByIngredientsResultHeaderView else { return }
            view.configure(title: header)
        }
    }
}
