//
//  CommunityInfoCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import Foundation

protocol ICommunityInfoCellViewModel: AnyObject {
    var title: String? { get }
    var subtitle: String? { get }
    var recipiesCount: String { get }
    var membersCount: String { get }
    var isJoined: Bool { get }
}

final class CommunityInfoCellViewModel: ICommunityInfoCellViewModel {
    var title: String?

    var subtitle: String?

    var recipiesCount: String

    var membersCount: String

    var isJoined: Bool

    init(title: String?, subtitle: String?, recipiesCount: String, membersCount: String, isJoined: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.recipiesCount = recipiesCount
        self.membersCount = membersCount
        self.isJoined = isJoined
    }
}
