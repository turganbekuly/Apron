//
//  CookNowCell+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.12.2022.
//

import UIKit

extension CookNowCell: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recipesSection.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesSection[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .shimmer:
            let cell: RecipeSearchSkeletonCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipe:
            let cell: RecipeSearchResultCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension CookNowCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
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
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .shimmer:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case .recipe:
            return CGSize(width: 170, height: 280)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? RecipeSearchResultCell else { return }
            cell.configure(with: recipe)
        case .shimmer:
            guard let cell = cell as? RecipeSearchSkeletonCell else { return }
            cell.configure()
        }
    }
}
