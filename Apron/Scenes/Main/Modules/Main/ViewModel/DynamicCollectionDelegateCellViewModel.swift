//
//  DynamicCollectionDelegateCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.05.2022.
//

import Models
import Storages
import APRUIKit

protocol IDynamicCollectionDelegateCellViewModel {
    var sectionHeaderTitle: String { get }
    var categoryID: Int { get }
    var dynamicCommunities: [CommunityResponse] { get }
}

struct DynamicCollectionDelegateCellViewModel: IDynamicCollectionDelegateCellViewModel {
    // MARK: - Properties

    var sectionHeaderTitle: String
    var categoryID: Int
    var dynamicCommunities: [CommunityResponse]
}
