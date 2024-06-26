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
            let cell: CookNowEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipe:
            let cell: RecipeSearchResultCellv2 = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension CookNowCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            delegate?.navigateToRecipev2(with: recipe.id)
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .shimmer:
            return CGSize(width: 230, height: 140)
        case .recipe:
            return CGSize(width: 230, height: 140)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? RecipeSearchResultCellv2 else { return }
            cell.delegate = self
            cell.configure(with: recipe)
        case .shimmer:
            guard let cell = cell as? CookNowEmptyCollectionCell else { return }
            cell.configure()
        }
    }
}
