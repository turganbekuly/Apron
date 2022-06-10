//
//  CustomViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import UIKit
import Protocols
import APRUIKit

final class CustomViewController: ViewController {

    public lazy var searchController: SearchController = {
        let searchController = SearchResultBuilder(state: .initial).build()
//        (searchController as? SearchResultViewController)?.delegate = self
        let controller = SearchController(searchResultsController: searchController)
        controller.definesPresentationContext = true
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.placeholder = "Поиск рецептов и сообществ"
//        controller.searchBar.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.searchController = searchController
    }
}
