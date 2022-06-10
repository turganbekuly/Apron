//
//  CollectionDelegateCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import Storages
import APRUIKit

protocol IMyCollectionDelegateCellViewModel {
    var myCommunities: [CommunityResponse] { get }
}

struct MyCollectionDelegateCellViewModel: IMyCollectionDelegateCellViewModel {
    // MARK: - Properties

    var myCommunities: [CommunityResponse]
}
