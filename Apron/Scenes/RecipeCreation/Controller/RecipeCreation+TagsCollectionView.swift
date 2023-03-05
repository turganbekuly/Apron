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

    enum SelectSuggestedType {
        case whenToCook(SuggestedDayTimeType)
        case dishType(SuggestedDishType)
        case lifeStyleType(SuggestedLifestyleType)
        case eventType(SuggestedEventType)
    }

    // MARK: - Auto Select Options

    public func isSelected(type: SelectSuggestedType) -> Bool {
        switch type {
        case .whenToCook(let value):
            return selectedCookingTime.contains(value)
        case .dishType(let value):
            return selectedDishTypes.contains(value)
        case .lifeStyleType(let value):
            return selectedLifestyleTypes.contains(value)
        case .eventType(let value):
            return selectedEventTypes.contains(value)
        }
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
        case .whenToCook, .dishType, .lifeStyleType, .eventType:
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
        case let .whenToCook(option):
            if selectedCookingTime.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedCookingTime.append(option)
            }
        case let .dishType(option):
            if selectedDishTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedDishTypes.append(option)
            }
        case let .lifeStyleType(option):
            if selectedLifestyleTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedLifestyleTypes.append(option)
            }
        case let .eventType(option):
            if selectedEventTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedEventTypes.append(option)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .whenToCook(option):
            selectedCookingTime.removeAll(where: { $0 == option })
        case let .dishType(option):
            selectedDishTypes.removeAll(where: { $0 == option })
        case let .lifeStyleType(option):
            selectedLifestyleTypes.removeAll(where: { $0 == option })
        case let .eventType(option):
            selectedEventTypes.removeAll(where: { $0 == option })
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .whenToCook(option):
            let width = min(Typography.regular16(text: option.title).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 36)
        case let .dishType(option):
            let width = min(Typography.regular16(text: option.title).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 36)
        case let .lifeStyleType(option):
            let width = min(Typography.regular16(text: option.title).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 36)
        case let .eventType(option):
            let width = min(Typography.regular16(text: option.title).styled.size().width + 16, collectionView.bounds.width)
            return CGSize(width: width, height: 36)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath
    ) {
        let row = tagsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .whenToCook(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(
                tag: option.title,
                isSelected: isSelected(type: .whenToCook(option))
            ))
        case let .dishType(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(
                tag: option.title,
                isSelected: isSelected(type: .dishType(option))
            ))
        case let .lifeStyleType(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(
                tag: option.title,
                isSelected: isSelected(type: .lifeStyleType(option))
            ))
        case let .eventType(option):
            guard let cell = cell as? TagCell else { return }

            cell.configure(with: TagCellViewModel(
                tag: option.title,
                isSelected: isSelected(type: .eventType(option))
            ))
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = tagsSections[indexPath.section].section
        switch section {
        case .whenToCook:
            let view: TagHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        case .dishType:
            let view: TagHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        case .lifeStyleType:
            let view: TagHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        case .eventType:
            let view: TagHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = tagsSections[section].section
        switch section {
        default:
            return CGSize(width: collectionView.bounds.width, height: 46)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        let section = tagsSections[indexPath.section].section
        switch section {
        case .whenToCook:
            guard let view = view as? TagHeader else { return }
            view.configure(title: "Укажите тип приема пищи")
        case .dishType:
            guard let view = view as? TagHeader else { return }
            view.configure(title: "Укажите тип блюда")
        case .lifeStyleType:
            guard let view = view as? TagHeader else { return }
            view.configure(title: "Укажите образ жизни")
        case .eventType:
            guard let view = view as? TagHeader else { return }
            view.configure(title: "Укажите праздники")
        }
    }
}
