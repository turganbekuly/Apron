//
//  RecipePage+Pager.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import UIKit

extension RecipePageViewController {

    // MARK: - Pager

    public func configurePager() {
        addChild(pagerViewController)
        scrollView.addSubview(pagerViewController.view)
        pagerViewController.view.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension RecipePageViewController: IRecipeInfoPagerViewController {

    // MARK: - PersonalAdsPagerViewControllerDelegate

    public func controller(_ controller: RecipeInfoPagerViewController, didSelectIndex index: Int) {
        guard
            let section = sections.firstIndex(where: { $0.section == .pages }),
            sections[section].rows[safe: index] != nil
        else {
            return
        }

        selectedIndexPath = IndexPath(row: index, section: section)
        mainView.selectItem(at: IndexPath(row: index, section: section), animated: true, scrollPosition: .bottom)
    }

}
