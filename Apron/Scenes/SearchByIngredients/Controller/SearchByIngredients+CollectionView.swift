//
//  SearchByIngredients+CollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 19.08.2023.
//

import Models
import APRUIKit
import UIKit
import HapticTouch

extension SearchByIngredientsViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .suggestedIngredient:
            let cell: SBIProductCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .selectedIngredient:
            let cell: SBIProductSelectedCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension SearchByIngredientsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .suggestedIngredient(product):
            if !selectedProducts.contains(where: { $0.id == product.id }) {
                selectedProducts.append(product)
                HapticTouch.generateSuccess()
            } else {
                show(type: .error(L10n.SearchByIngredients.Product.alreadyAdded))
                HapticTouch.generateError()
            }
        default:
            break
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .suggestedIngredient, .selectedIngredient:
            return CGSize(
                width: (collectionView.bounds.width / 4) - 26,
                height: (collectionView.bounds.width / 4) + 24
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .suggestedIngredient(product):
            guard let cell = cell as? SBIProductCollectionCell else { return }
            cell.configure(with: product)
        case let .selectedIngredient(product):
            guard let cell = cell as? SBIProductSelectedCollectionCell else { return }
            cell.delegate = self
            cell.configure(with: product)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
            let section = sections[indexPath.section].section
            switch section {
            case .selectedIngredients, .suggestedIngredients:
                let view: SBIIngredientsHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                return view
            }
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = sections[section].section
        switch section {
        case .selectedIngredients, .suggestedIngredients:
            return CGSize(width: collectionView.bounds.width, height: 36)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        let section = sections[indexPath.section].section
        switch section {
        case .selectedIngredients:
            guard let view = view as? SBIIngredientsHeaderView else { return }
            view.configure(with: L10n.SearchByIngredients.Product.selectedProducts)
        case .suggestedIngredients:
            guard let view = view as? SBIIngredientsHeaderView else { return }
            view.configure(with: L10n.SearchByIngredients.Product.suggestedProducts)
        }
    }
}

