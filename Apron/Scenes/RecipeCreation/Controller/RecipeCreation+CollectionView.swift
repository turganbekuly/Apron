//
//  RecipeCreation+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipeCreationViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .image:
            let cell: RecipeCreationImageCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .description:
            let cell: RecipeCreationDescriptionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .composition:
            let cell: RecipeCreationAddIngredientCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .instruction:
            let cell: RecipeCreationAddInstructionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .servings:
            let cell: RecipeCreationAssignCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .prepTime:
            let cell: RecipeCreationAssignCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .cookTime:
            let cell: RecipeCreationAssignCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: RecipeCreationNamingCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension RecipeCreationViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            return CGSize(width: collectionView.bounds.width, height: 54)
        case .image:
            return CGSize(width: collectionView.bounds.width, height: 167)
        case .description:
            return CGSize(width: collectionView.bounds.width, height: 125)
        case .composition:
            return CGSize(
                width: collectionView.bounds.width,
                height: 86
            )
        case .instruction:
            return CGSize(
                width: collectionView.bounds.width,
                height: 86
            )
        case .servings:
            return CGSize(width: collectionView.bounds.width, height: 70)
        case .prepTime:
            return CGSize(width: collectionView.bounds.width, height: 70)
        case .cookTime:
            return CGSize(width: collectionView.bounds.width, height: 70)
        default:
            return CGSize(width: collectionView.bounds.width, height: 600)

        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            guard let cell = cell as? RecipeCreationNamingCell else { return }
            cell.configure()
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.configure()
        case .description:
            guard let cell = cell as? RecipeCreationDescriptionCell else  { return }
            cell.configure()
        case .composition:
            guard let cell = cell as? RecipeCreationAddIngredientCell else { return }
            cell.configure(delegate: self, newIngredientDelegate: self)
        case .instruction:
            guard let cell = cell as? RecipeCreationAddInstructionCell else { return }
            cell.configure(delegate: self)
        case .servings:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.configure(type: .servings)
        case .prepTime:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.configure(type: .prepTime)
        case .cookTime:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.configure(type: .cookTime)
        default: break
        }
    }
}
