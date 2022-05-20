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
}

final class CommunityInfoCellViewModel: ICommunityInfoCellViewModel {
    var community: CommunityResponse?

    init(community: CommunityResponse?) {
        self.community = community
    }
}
