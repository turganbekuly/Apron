//
//  CommunitiesListInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.05.2022.
//

import Foundation

enum CommunitiesListInitialState {
    case myCommunities
    case all(id: Int, name: String)
}
