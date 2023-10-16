//
//  MealPlannerCell+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.01.2023.
//

import UIKit
import Models
import APRUIKit

extension MealPlannerCell: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        recipesSections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipesSections[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = recipesSections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe:
            let cell: MealPlannerCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .shimmer:
            let cell: CookNowEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension MealPlannerCell: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = recipesSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe, _):
            delegate?.openRecipe(with: recipe.id)
        default:
            break
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = recipesSections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipe, .shimmer:
            return CGSize(width: 160, height: 200)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = recipesSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe, weekday):
            guard let cell = cell as? MealPlannerCollectionCell else { return }
            cell.delegate = self
            cell.configure(with: recipe, with: weekday)
        case .shimmer:
            guard let cell = cell as? CookNowEmptyCollectionCell else { return }
            cell.configure()
        }
    }
}
