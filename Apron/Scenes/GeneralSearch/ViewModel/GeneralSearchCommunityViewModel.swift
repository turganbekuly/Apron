//
//  GeneralSearchCommunityViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Models

protocol GeneralSearchCommunityViewModelProtocol {
    var community: CommunityResponse? { get }
}

struct GeneralSearchCommunityViewModel: GeneralSearchCommunityViewModelProtocol {
    var community: CommunityResponse?
}
