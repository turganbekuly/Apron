//
//  SearchController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import UIKit

public final class SearchController: UISearchController, UISearchBarDelegate {

    // MARK: - Properties

    override public var searchBar: UISearchBar {
        _searchBar
    }

    // MARK: - Views

    private lazy var _searchBar: SearchBar = { [weak self] in
        let result = SearchBar(frame: .zero)
        return result
    }()

    // MARK: - Init

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    override public init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
    }

    public required init?(coder: NSCoder) {
        nil
    }

}
