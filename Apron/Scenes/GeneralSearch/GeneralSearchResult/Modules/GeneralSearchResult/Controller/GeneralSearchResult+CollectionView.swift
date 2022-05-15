//
//  GeneralSearchResult+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.05.2022.
//

import DesignSystem
import UIKit

extension GeneralSearchResultViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .result:
            let cell: SegmentItemCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension GeneralSearchResultViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .result:
            selectedIndexPath = indexPath
            collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
            pagerViewController.setFirst(index: indexPath.row)
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .result(resultPage):
            let width = Typography.semibold16(text: resultPage.title ?? "").styled.size().width + 32
            return CGSize(width: width, height: collectionView.bounds.height)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .result(resultPage):
            guard let cell = cell as? SegmentItemCell else { return }

            cell.configure(with: SegmentCellViewModel(name: resultPage.title ?? ""))
            cell.isSelected = selectedIndexPath == indexPath
            if selectedIndexPath == indexPath {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            } else {
                collectionView.deselectItem(at: indexPath, animated: false)
            }
        }
    }

}

