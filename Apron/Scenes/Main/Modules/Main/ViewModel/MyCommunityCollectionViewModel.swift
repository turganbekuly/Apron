//
//  MyCommunityCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.05.2022.
//

import Models
import UIKit

protocol MyCommunityCollectionViewModelProtocol {
    var imageURL: UIImage? { get }
    var communityName: String { get }
}

struct MyCommunityCollectionViewModel: MyCommunityCollectionViewModelProtocol {
    // MARK: - Properties

    var imageURL: UIImage?
    var communityName: String
}
