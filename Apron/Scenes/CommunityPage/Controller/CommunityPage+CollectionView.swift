//
//  CommunityPage+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import Foundation
import UIKit

extension CommunityPageViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case is RecipeCollectionView:
            return recipesSection.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case is RecipeCollectionView:
            return recipesSection[section].rows.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        default: //case is RecipeCollectionView:
            let row: CommunityPageViewController.CommunityPageCollectionSection.Row = recipesSection[indexPath.section].rows[indexPath.row]
            switch row {
            default:
                let cell: RecipeCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        }
    }
}

extension CommunityPageViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = recipesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipes:
            let vc = RecipePageBuilder(state: .initial).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        default: //case is RecipeCollectionView:
            let row: CommunityPageViewController.CommunityPageCollectionSection.Row = recipesSection[indexPath.section].rows[indexPath.row]
            switch row {
            default:
                return CGSize(width: collectionView.bounds.width - 32, height: (collectionView.bounds.width / 2) + 20)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        default: //case is RecipeCollectionView:
            let row: CommunityPageViewController.CommunityPageCollectionSection.Row = recipesSection[indexPath.section].rows[indexPath.row]
            switch row {
            case let .recipes(recipes):
                guard let cell = cell as? RecipeCollectionCell else { return }
                cell.configure(with: recipes)
            }
        }
    }
}
