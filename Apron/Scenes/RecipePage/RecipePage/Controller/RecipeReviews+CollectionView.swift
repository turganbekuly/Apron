//
//  RecipeReviews+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import Models
import APRUIKit
import UIKit


extension RecipeReviewsCell: UICollectionViewDataSource {

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
        case .chip:
            let cell: RecipeChipCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension RecipeReviewsCell: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .chip(chip):
            let width = min(Typography.regular14(text: chip).styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 24)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .chip(chip):
            guard let cell = cell as? RecipeChipCell else { return }
            cell.configure(with: ChipCellViewModel(chip: chip))
            tagsCollectionViewHeight?.update(offset: tagsCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
}


