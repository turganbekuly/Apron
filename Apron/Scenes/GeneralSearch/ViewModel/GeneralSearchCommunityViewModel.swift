//
//  GeneralSearchCommunityViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Foundation

protocol GeneralSearchCommunityViewModelProtocol {
    var image: String? { get }
    var name: String { get }
    var memberCount: String { get }
    var recipeCount: String { get }
    var isJoined: Bool { get }
}

struct GeneralSearchCommunityViewModel: GeneralSearchCommunityViewModelProtocol {
    var image: String?

    var name: String

    var memberCount: String

    var recipeCount: String

    var isJoined: Bool
}
