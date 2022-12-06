//
//  CookNowCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.12.2022.
//

import Models
import UIKit

protocol CookNowCellViewModelProtocol {
    var sectionTitle: String { get }
    var recipes: [RecipeResponse] { get }
}

struct CookNowCellViewModel: CookNowCellViewModelProtocol {
    // MARK: - Properties

    var sectionTitle: String
    var recipes: [RecipeResponse]
}
