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
        case initial(Int)
        case displayCommunity(CommunityResponse)
        case displayCommunityError(AKNetworkError)
        case joinedCommunity
        case joinedCommunityFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(id):
            getCommunities(by: id)
        case let .displayCommunity(model):
            self.community = model
        case let .displayCommunityError(error):
            print(error)
        case .joinedCommunity:
            print("")
        case .joinedCommunityFailed:
            print("")
        }
    }
    
}
