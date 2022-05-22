//
//  CaloriesCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.05.2022.
//

import Foundation

protocol CaloriesCellViewModelProtocol {
    var proteinCount: Double? { get }
    var fatCount: Double? { get }
    var carbsCount: Double? { get }
    var ccalCount: Double? { get }
}

struct CaloriesCellViewModel: CaloriesCellViewModelProtocol {
    var proteinCount: Double?

    var fatCount: Double?

    var carbsCount: Double?

    var ccalCount: Double?
}
