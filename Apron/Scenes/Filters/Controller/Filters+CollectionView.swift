//
//  Filters+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Models
import APRUIKit

extension FiltersViewController {

    // MARK: - Auto Select Options

    public func isSelected(type: FilterOptionType) -> Bool {
        switch type {
        case .cookingTime(let suggestedCookingTime):
            return selectedFilters.cookingTime.contains(suggestedCookingTime)
        case .cuisine(let recipeCuisine):
            return selectedFilters.cuisines.contains(recipeCuisine)
        case .dishType(let suggestedDishType):
            return selectedFilters.dishTypes.contains(suggestedDishType)
        case .ingredient(let recipeIngredient):
            return selectedFilters.ingredients.contains(recipeIngredient)
        case .eventType(let suggestedEventType):
            return selectedFilters.eventTypes.contains(suggestedEventType)
        case .lifestyleType(let suggestedLifestyleType):
            return selectedFilters.lifestyleTypes.contains(suggestedLifestyleType)
        }
    }

}

extension FiltersViewController: UICollectionViewDataSource {

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
        case .addIngredient, .addCuisine:
            let cell: FilterActionButton = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: FilterOptionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension FiltersViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .cookingTime(option):
            if selectedFilters.cookingTime.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.cookingTime.append(option)
            }
        case let .cuisine(option):
            if selectedFilters.cuisines.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.cuisines.append(option)
            }
        case let .dishType(option):
            if selectedFilters.dishTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.dishTypes.append(option)
            }
        case let .ingredient(option):
            if selectedFilters.ingredients.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.ingredients.append(option)
            }
        case let .eventType(option):
            if selectedFilters.eventTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.eventTypes.append(option)
            }
        case let .lifestyleType(option):
            if selectedFilters.lifestyleTypes.contains(option) {
                collectionView.deselectItem(at: indexPath, animated: false)
                collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            } else {
                selectedFilters.lifestyleTypes.append(option)
            }
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .cookingTime(option):
            selectedFilters.cookingTime.removeAll(where: { $0 == option })
        case let .cuisine(option):
            selectedFilters.cuisines.removeAll(where: { $0 == option })
        case let .dishType(option):
            selectedFilters.dishTypes.removeAll(where: { $0 == option })
        case let .ingredient(option):
            selectedFilters.ingredients.removeAll(where: { $0 == option })
        case let .eventType(option):
            selectedFilters.eventTypes.removeAll(where: { $0 == option })
        case let .lifestyleType(option):
            selectedFilters.lifestyleTypes.removeAll(where: { $0 == option })
        default:
            break
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .cookingTime(option):
            let width = min(Typography.regular14(text: option.title).styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case let .cuisine(option):
            let width = min(Typography.regular14(text: option.name ?? "").styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case let .dishType(option):
            let width = min(Typography.regular14(text: option.title).styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case let .ingredient(option):
            let width = min(Typography.regular14(text: option.product?.name ?? "").styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case let .eventType(option):
            let width = min(Typography.regular14(text: option.title).styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case let .lifestyleType(option):
            let width = min(Typography.regular14(text: option.title).styled.size().width + 24, collectionView.bounds.width)
            return CGSize(width: width, height: 40)
        case .addIngredient, .addCuisine:
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .cookingTime(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .cookingTime(option),
                isSelected: isSelected(type: .cookingTime(option))
            ))
        case let .cuisine(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .cuisine(option),
                isSelected: isSelected(type: .cuisine(option))
            ))
        case let .dishType(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .dishType(option),
                isSelected: isSelected(type: .dishType(option))
            ))
        case let .ingredient(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .ingredient(option),
                isSelected: isSelected(type: .ingredient(option))
            ))
        case let .eventType(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .eventType(option),
                isSelected: isSelected(type: .eventType(option))
            ))
        case let .lifestyleType(option):
            guard let cell = cell as? FilterOptionCell else { return }
            cell.configure(with: FilterOptionCellViewModel(
                type: .lifestyleType(option),
                isSelected: isSelected(type: .lifestyleType(option))
            ))
        case .addIngredient:
            guard let cell = cell as? FilterActionButton else { return }
            cell.configure(with: .ingredients)
        case .addCuisine:
            guard let cell = cell as? FilterActionButton else { return }
            cell.configure(with: .cuisines)
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = sections[indexPath.section].section
        switch section {
        case .addIngredient, .addCuisine:
            let view: UICollectionReusableView = collectionView.dequeueReusableCell(withReuseIdentifier: kind, for: indexPath)
            return view
        default:
            let view: FiltersHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = sections[section].section
        switch section {
        case .addIngredient, .addCuisine:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: collectionView.bounds.width, height: 64)
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        let section = sections[indexPath.section].section
        switch section {
        case .cookingTime:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Тип приема пищи"))
        case .cuisines:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Кухня мира"))
        case .dishTypes:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Тип блюда"))
        case .ingredients:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Добавить продукт"))
        case .eventTypes:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Праздники"))
        case .lifestyleTypes:
            guard let view = view as? FiltersHeaderView else { return }
            view.configure(with: FilterHeaderViewModel(text: "Стиль жизни"))
        case .addIngredient, .addCuisine:
            break
        }
    }

}

