//
//  RecipeSearch+SearchBar.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.10.2022.
//

import Foundation

extension RecipeSearchViewController: APSearchBarDelegate {
    func searchBar(_ searchBar: APSearchBar, textDidChange text: String) {
        query = text

        if text.isEmpty {
            sections = [
                .init(section: .trendings, rows: SearchSuggestionCategoriesTypes.allCases.compactMap { .trending($0) })
            ]
            mainView.reloadData()
        }
    }
}
