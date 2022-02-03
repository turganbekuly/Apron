//
//  CommunityCollectionCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import Storages
import DesignSystem
import UIKit

protocol ICommunityCollectionCellViewModel {
    var imageURL: UIImage? { get }
    var communityName: String { get }
    var recipeCount: String { get }
    var membersCount: String { get }
    var isMyCommunity: Bool { get }
    var onJoinButtonTapped: (() -> Void)? { get }
}

struct CommunityCollectionCellViewModel: ICommunityCollectionCellViewModel {
    // MARK: - Properties

    var imageURL: UIImage?
    var communityName: String
    var recipeCount: String
    var membersCount: String
    var isMyCommunity: Bool
    var onJoinButtonTapped: (() -> Void)?

    // MARK: - Init

    init(
        imageURL: UIImage?,
        communityName: String,
        recipeCount: String,
        membersCount: String,
        onJoinButtonTapped: (() -> Void)?,
        isMyCommunity: Bool = false
    ) {
        self.imageURL = imageURL
        self.communityName = communityName
        self.recipeCount = recipeCount
        self.membersCount = membersCount
        self.onJoinButtonTapped = onJoinButtonTapped
        self.isMyCommunity = isMyCommunity
    }
}

