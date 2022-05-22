//
//  GeneralSearch+SearchDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit

extension GeneralSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
}


extension GeneralSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let viewController = searchController.searchResultsController as? GeneralSearchResultViewController else { return }
        viewController.searchTerm = searchController.searchBar.text
    }
}

extension GeneralSearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
