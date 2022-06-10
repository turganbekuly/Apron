//
//  CommunityCollectionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import Storages
import APRUIKit
import UIKit

protocol ICommunityCollectionCellViewModel {
    var community: CommunityResponse? { get }
}

struct CommunityCollectionCellViewModel: ICommunityCollectionCellViewModel {
    // MARK: - Properties

    var community: CommunityResponse?
}

