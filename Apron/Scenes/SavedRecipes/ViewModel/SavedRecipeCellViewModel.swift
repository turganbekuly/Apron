//
//  SavedRecipeCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.06.2022.
//

import Foundation

protocol SavedRecipeCellViewModelProtocol {
    var image: String? { get }
    var name: String? { get }
}

struct SavedRecipeCellViewModel: SavedRecipeCellViewModelProtocol {
    let image: String?
    let name: String?
}
