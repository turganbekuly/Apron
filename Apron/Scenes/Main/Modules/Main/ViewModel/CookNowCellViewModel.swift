//
//  CookNowCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.12.2022.
//

import Models
import UIKit

enum CookNowCellState {
    case failed
    case loading
    case loaded([RecipeResponse])
}

enum CookNowCellType {
    case cookNow
    case eventRecipe
}

protocol CookNowCellViewModelProtocol {
    var sectionTitle: String { get }
    var type: CookNowCellType { get }
    var state: CookNowCellState { get }
}

struct CookNowCellViewModel: CookNowCellViewModelProtocol {
    // MARK: - Properties

    var sectionTitle: String
    var type: CookNowCellType
    var state: CookNowCellState
}
