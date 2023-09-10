//
//  CommunityCellViewModel.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 13.08.2023.
//

import Models
import Storages
import APRUIKit

protocol CommunityCellViewModelProtocol {
    var sectionHeaderTitle: String { get }
    var communities: [CommunityResponse] { get }
}

struct CommunityCellViewModel: CommunityCellViewModelProtocol {
    // MARK: - Properties

    var sectionHeaderTitle: String
    var communities: [CommunityResponse]
}

