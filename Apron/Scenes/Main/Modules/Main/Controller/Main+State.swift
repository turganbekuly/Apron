//
//  Main+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import DesignSystem

extension MainViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case joinedCommunity
        case joinedCommunityFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            myCommunitySections = [.init(section: .myCommunities, rows: myRecipes[0].compactMap { .community($0) })]
            featuredCommunitySections = [.init(section: .featuredCommunities, rows: myRecipes[1].compactMap { .community($0) })]
            quickCommunitySections = [.init(section: .quickSimpleCommunities, rows: myRecipes[2].compactMap { .community($0) })]
            healthCommunitySections = [.init(section: .healthyCommunities, rows: myRecipes[3].compactMap { .community($0) })]
            homeCommunitySections = [.init(section: .homemadeCommunities, rows: myRecipes[4].compactMap { .community($0) })]
        case .joinedCommunity:
            print("")
        case .joinedCommunityFailed:
            print("")
        }
    }
    
}
