//
//  RecipeRecommendations+CollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 28.06.2023.
//

import Models
import APRUIKit
import UIKit

extension RecipeSimilarRecommendationsCell: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe:
            let cell: RecipeSearchResultCellv2 = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension RecipeSimilarRecommendationsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            delegate?.recipeSelected(recipe, row: (CGFloat(indexPath.row + 1) / 2).rounded(.up))
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 240)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? RecipeSearchResultCellv2 else { return }
            cell.configure(with: recipe)
        }
    }
}

