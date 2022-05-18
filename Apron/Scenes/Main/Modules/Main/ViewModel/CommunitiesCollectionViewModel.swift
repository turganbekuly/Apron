//
//  CommunitiesCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.05.2022.
//

import Foundation

protocol CommunitiesCollectionViewModelProtocol {
    var sectionTitle: String { get }
    var communities: [CommunityCollectionCellViewModel] { get }
}

struct CommunitiesCollectionViewModel: CommunitiesCollectionViewModelProtocol {
    var sectionTitle: String
    var communities: [CommunityCollectionCellViewModel]
}
