//
//  MyCommunityCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.05.2022.
//

import Models
import UIKit

protocol MyCommunityCollectionViewModelProtocol {
    var community: CommunityResponse? { get }
}

struct MyCommunityCollectionViewModel: MyCommunityCollectionViewModelProtocol {
    // MARK: - Properties

    var community: CommunityResponse?
}
