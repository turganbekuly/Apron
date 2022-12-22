//
//  Search+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.06.2022.
//

import Foundation
import UIKit
import Storages
import Models

extension SearchViewController: SearchHeaderViewDelegate {
    func onSearchDidTap() {
        let viewController = UINavigationController(
            rootViewController: RecipeSearchBuilder(state: .initial(SearchFilterRequestBody())).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}
