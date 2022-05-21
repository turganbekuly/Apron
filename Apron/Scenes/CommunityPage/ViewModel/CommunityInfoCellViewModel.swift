//
//  CommunityInfoCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import Foundation
import Models

protocol ICommunityInfoCellViewModel: AnyObject {
    var community: CommunityResponse? { get }
    var searchbarPlaceholder: String { get }
}

final class CommunityInfoCellViewModel: ICommunityInfoCellViewModel {
    var community: CommunityResponse?
    var searchbarPlaceholder: String

    init(
        community: CommunityResponse?,
        searchbarPlaceholder: String
    ) {
        self.community = community
        self.searchbarPlaceholder = searchbarPlaceholder
    }
}
