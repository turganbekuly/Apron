//
//  Search+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import Models
import APRUIKit
import UIKit


extension SearchViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        categoryCollectionCell.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryCollectionCell[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = categoryCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            let cell: SearchSuggestionCategoryCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = categoryCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case.category:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 160)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = categoryCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case let .category(category):
            guard let cell = cell as? SearchSuggestionCategoryCollectionCell else { return }
            cell.configure(with: category)
        }
    }
}

