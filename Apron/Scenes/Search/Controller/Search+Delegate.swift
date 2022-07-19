//
//  Search+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.06.2022.
//

import Foundation
import UIKit
import Storages

extension SearchViewController: SearchHeaderViewDelegate {
    func onSearchDidTap() {
        let viewController = UINavigationController(
            rootViewController: GeneralSearchBuilder(
                state: .initial(.main)).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}

extension SearchViewController: SearchHistoryCollectionCellDelegate {
    func searchHistorySelected(with search: SearchHistoryItem) {
        let viewController = UINavigationController(
            rootViewController: GeneralSearchBuilder(
                state: .initial(.main, search.text)).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }

    func removeButtonTapped(with search: SearchHistoryItem) {
        removeSearchQuery(with: search.id)
        configureHistory()
    }
}
