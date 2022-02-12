//
//  RecipePage+Pager.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import UIKit

extension RecipePageViewController: IRecipeInfoPagerViewController {

    // MARK: - PersonalAdsPagerViewControllerDelegate

    public func controller(_ controller: RecipeInfoPagerViewController, didSelectIndex index: Int) {
        guard
            let section = sections.firstIndex(where: { $0.section == .pages })
        else {
            return
        }

        selectedIndexPath = IndexPath(row: index, section: section)
        let header = mainView.headerView(forSection: section) as? SegmentedTableHeaderView
        header?.segmentedControl.selectedSegmentIndex = index
    }

}
