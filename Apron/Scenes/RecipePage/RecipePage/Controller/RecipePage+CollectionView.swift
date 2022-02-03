//
//  RecipePage+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import DesignSystem
import UIKit

extension RecipePageViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .page:
            let cell: SegmentCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension RecipePageViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .page:
            selectedIndexPath = indexPath
            collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
            pagerViewController.setFirst(index: indexPath.row)
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .page:
            return CGSize(width: mainView.bounds.width / 3, height: 34)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .page(state):
            guard let cell = cell as? SegmentCollectionViewCell else { return }

            cell.configure(with: SegmentCollectionViewModel(name: state.title))
            cell.isSelected = selectedIndexPath == indexPath
            if selectedIndexPath == indexPath {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            } else {
                collectionView.deselectItem(at: indexPath, animated: false)
            }
        }
    }

}

