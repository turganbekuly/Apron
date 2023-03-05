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

protocol CookNowCellViewModelProtocol {
    var sectionTitle: String { get }
    var state: CookNowCellState { get }
}

struct CookNowCellViewModel: CookNowCellViewModelProtocol {
    // MARK: - Properties

    var sectionTitle: String
    var state: CookNowCellState
}
