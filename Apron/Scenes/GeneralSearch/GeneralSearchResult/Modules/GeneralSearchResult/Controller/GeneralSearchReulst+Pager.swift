//
//  GeneralSearchReulst+Pager.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.05.2022.
//

import UIKit

extension GeneralSearchResultViewController {

    // MARK: - Pager
    public func configurePager() {
        addChild(pagerViewController)
        view.addSubview(pagerViewController.view)
        pagerViewController.view.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension GeneralSearchResultViewController: GeneralSearchResultPagerViewControllerDelegate {

    // MARK: - GeneralSearchResultPagerViewControllerDelegate
    public func controller(_ controller: GeneralSearchResultPagerViewController, didSelectIndex index: Int) {
        guard let section = sections.firstIndex(where: { $0.section == .results }),
              sections[section].rows[safe: index] != nil else {
            return
        }

        selectedIndexPath = IndexPath(row: index, section: section)
        mainView.selectItem(at: IndexPath(row: index, section: section), animated: true, scrollPosition: .centeredHorizontally)
    }

}

