//
//  MyRecipes+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.01.2023.
//

import UIKit
import OneSignal
import APRUIKit

extension MyRecipesViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .shimmer:
            let cell: RecipeSearchSkeletonCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .empty:
            let cell: MyRecipesEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipe:
            let cell: MyRecipesCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MyRecipesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            let vc = RecipePageBuilder(state: .initial(id: recipe.id, .myRecipes)).build()
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
        case .shimmer:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case .empty:
            return CGSize(width: collectionView.bounds.width, height: 230)
        case .recipe:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 240)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? MyRecipesCollectionCell else { return }
            cell.configure(with: recipe)
        case .empty:
            guard let cell = cell as? MyRecipesEmptyCollectionCell else { return }
            cell.configure(
                with: "У вас еще нет созданных рецептов",
                image: ApronAssets.emptyRecipesIcon.image
            )
        case .shimmer:
            guard let cell = cell as? RecipeSearchSkeletonCell else { return }
            cell.configure()
        }
    }
}

