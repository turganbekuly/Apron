//
//  SBIMainViewModel.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import Models

protocol SBIMainViewModelProtocol {
    var sectionTitle: String { get }
    var sectionDescription: String { get }
    var products: [Product] { get }
}

struct SBIMainViewModel: SBIMainViewModelProtocol {
    // MARK: - Properties

    var sectionTitle: String
    var sectionDescription: String
    var products: [Product]
}
