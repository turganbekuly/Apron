//
//  AddComment+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import Models
import APRUIKit
import UIKit

extension AddCommentViewController {

    // MARK: - Auto Select Options

    public func isSelected(option: String) -> Bool {
        selectedOptions.contains(option)
    }

}

extension AddCommentViewController: UICollectionViewDataSource {

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

extension AddCommentViewController: UICollectionViewDelegateFlowLayout {

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
            let width = min(Typography.regular14(text: option).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 24)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(tag: option, isSelected: isSelected(option: option)))
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = tagsSections[indexPath.section].section
        switch section {
        case .howDidItTaste, .whatWasGood, .makeItAgain:
            let view: TagHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = tagsSections[section].section
        switch section {
        case .howDidItTaste, .whatWasGood, .makeItAgain:
            return CGSize(width: collectionView.bounds.width, height: 46)
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        let section = tagsSections[indexPath.section].section
        switch section {
        case let .howDidItTaste(option),
            let .whatWasGood(option),
            let .makeItAgain(option):
            guard let view = view as? TagHeader else { return }

            view.configure(title: option)
        }
    }

}
