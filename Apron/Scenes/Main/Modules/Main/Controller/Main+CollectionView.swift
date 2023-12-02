//
//  Main+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Foundation
import UIKit
import Extensions

extension MainViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            let cell: CommunityCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .whatToCook:
            let cell: WhatToCookCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        case .eventRecipes:
            let cell: CookNowCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .cookNow:
            let cell: RecipeSearchResultCellv2 = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .adBanner:
            let cell: AdBannerCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .searchByIngredients:
            let cell: SBIMainTableCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipeLoader:
            let cell: RecipeSearchSkeletonCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .cookNow(recipe):
            let viewContoller = RecipePageBuilder(state: .initial(id: recipe.id, .main)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewContoller, animated: true)
            }
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            return CGSize(width: collectionView.bounds.width, height: communities.isEmpty ? 0 : ((UIScreen.main.bounds.width / 2) + 66) * 1.2)
        case .whatToCook:
//            let rawCount = CGFloat(WhatToCookCategoryTypes.allCases.count / 3)
            let categoryCellHeight: CGFloat = ((UIScreen.main.bounds.width + 60) * 168.0) / 375.0
//            return /*rawCount **/ categoryCellHeight
            return CGSize(width: collectionView.bounds.width, height: categoryCellHeight)
        case .eventRecipes:
            return CGSize(width: collectionView.bounds.width, height: 185)
        case .cookNow:
            return CGSize(width: (collectionView.bounds.width / 2) - 24, height: 240)
        case .recipeLoader:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        case .adBanner:
            return CGSize(width: collectionView.bounds.width, height: adBanners.count == 0 ? 0 : ((UIScreen.main.bounds.width / 375) * 134) + 60)
        case .searchByIngredients:
            guard !Device.isSmallIphones() else {
                return CGSize(width: collectionView.bounds.width, height: 170)
            }
            
            return CGSize(width: collectionView.bounds.width, height: 150)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .communities(title, communities):
            guard let cell = cell as? CommunityCell else { return }
            cell.delegate = self
            cell.configure(
                with: CommunityCellViewModel(
                    sectionHeaderTitle: title,
                    communities: communities
                )
            )
        case let .whatToCook(sectionTitle):
            guard let cell = cell as? WhatToCookCell else { return }
            cell.configure(
                with: WhatToCookCellViewModel(
                    sectionHeaderTitle: sectionTitle,
                    categories: WhatToCookCategoryTypes.allCases
                )
            )
        case let .cookNow(recipe):
            guard let cell = cell as? RecipeSearchResultCellv2 else { return }
            cell.configure(with: recipe)
        case let .eventRecipes(sectionTitle, _):
            guard let cell = cell as? CookNowCell else { return }
            cell.delegate = self
            cell.configure(
                with: CookNowCellViewModel(
                    sectionTitle: sectionTitle,
                    type: .eventRecipe,
                    state: eventRecipesState
                )
            )
        case let .adBanner(banners):
            guard let cell = cell as? AdBannerCell else { return }
            cell.delegate = self
            cell.configure(viewModel: banners)
            
        case let .searchByIngredients(sectionTitle, sectionDescr, products):
            guard let cell = cell as? SBIMainTableCell else { return }
            cell.delegate = self
            cell.configure(with: SBIMainViewModel(sectionTitle: sectionTitle, sectionDescription: sectionDescr, products: products))
        case .recipeLoader:
            guard let cell = cell as? RecipeSearchSkeletonCell else { return }
            cell.configure()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section].section
        switch section {
        default:
            let view: DividerHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            return view
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = sections[section].section
        switch section {
        case .cookNow:
            return CGSize(width: collectionView.bounds.width, height: 40)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
}
