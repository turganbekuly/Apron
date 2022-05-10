//
//  CommunityPage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CommunityPageViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case displayCommunity(CommunityResponse)
        case displayCommunityError(AKNetworkError)
        case joinedCommunity
        case joinedCommunityFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [
                .init(section: .topView, rows: topInfo.compactMap { .topView($0) }),
                .init(section: .filterView, rows: filter.compactMap { .filterView($0) }),
                .init(section: .recipiesView, rows: [.segment]),
                .init(section: .recipiesView, rows: [.recipiesView])
            ]

            recipesSection = [
                .init(section: .recipes, rows: recipies.compactMap { .recipes($0) })
            ]
        case let .displayCommunity(model):
            print(model)
        case let .displayCommunityError(error):
            print(error)
        case .joinedCommunity:
            print("")
        case .joinedCommunityFailed:
            print("")
        }
    }
    
}
