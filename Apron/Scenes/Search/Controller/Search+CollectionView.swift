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
        historyCollectionCell.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        historyCollectionCell[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = historyCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case .history:
            let cell: SearchHistoryCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
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
        let row = historyCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case let .history(history):
            let width = min(Typography.regular14(text: history.text).styled.size().width + 52, collectionView.bounds.width)
            return CGSize(width: width, height: 42)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = historyCollectionCell[indexPath.section].rows[indexPath.row]
        switch row {
        case let .history(history):
            guard let cell = cell as? SearchHistoryCollectionCell else { return }
            cell.delegate = self
            cell.configure(searchItem: history)
        }
    }
}

