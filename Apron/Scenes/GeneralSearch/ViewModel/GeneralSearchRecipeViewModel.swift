//
//  GeneralSearchRecipeViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Foundation

protocol GeneralSearchRecipeViewModelProtocol {
    var image: String? { get }
    var name: String { get }
    var sourceLink: String? { get }
    var isSaved: Bool { get }
}

struct GeneralSearchRecipeViewModel: GeneralSearchRecipeViewModelProtocol {
    var image: String?

    var name: String

    var sourceLink: String?

    var isSaved: Bool
}

