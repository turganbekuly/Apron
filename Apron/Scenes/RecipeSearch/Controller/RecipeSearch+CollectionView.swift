//
//  RecipeSearch+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipeSearchViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .trending:
            let cell: RecipeSearchSuggestionsCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .shimmer:
            let cell: RecipeSearchSkeletonCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .result:
            let cell: RecipeSearchResultCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipeSearchViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
//        case let .recipe(recipe):
//            if selectedRecipes.contains(recipe.id) {
//                collectionView.deselectItem(at: indexPath, animated: false)
//            } else {
//                selectedRecipes.append(recipe.id)
//            }
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .trending:
            return CGSize(width: collectionView.bounds.width - 32, height: 30)
        case .shimmer:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case .result:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 300)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .result(recipe):
            guard let cell = cell as? RecipeSearchResultCell else { return }
            cell.configure(with: recipe)
        case let .trending(trend):
            guard let cell = cell as? RecipeSearchSuggestionsCell else { return }
            cell.configure(title: trend)
        case .shimmer:
            guard let cell = cell as? RecipeSearchSkeletonCell else { return }
            cell.configure()
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

