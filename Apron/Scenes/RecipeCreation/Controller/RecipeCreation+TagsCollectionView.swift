//
//  RecipeCreation+TagsCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import Models
import APRUIKit
import UIKit

extension RecipeCreationViewController {

    // MARK: - Auto Select Options

    public func isSelected(option: SuggestedCookingTime) -> Bool {
        selectedOptions.contains(option)
    }
}

extension RecipeCreationViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        tagsSections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsSections[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case .option:
            let cell: TagCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension RecipeCreationViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            if selectedOptions.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedOptions.append(option)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            selectedOptions.removeAll(where: { $0 == option })
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            let width = min(Typography.regular14(text: option.title).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 24)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(tag: option.title, isSelected: isSelected(option: option)))
        }
    }
}

