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
        case fetchCommunitiesByCategory([CommunityCategory])
        case fetchCommunitiesByCategoryFailed(AKNetworkError)
        case fetchMyCommunities([CommunityResponse])
        case fetchMyCommunititesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            getMyCommunities()
            getCommunitiesByCategory()
        case .joinedCommunity:
            getMyCommunities()
            getCommunitiesByCategory()
        case .joinedCommunityFailed:
            print("")
        case let .fetchCommunitiesByCategory(model):
            self.dynamicCommunities = model
            endRefreshingIfNeeded()
        case let .fetchCommunitiesByCategoryFailed(error):
            print(error)
            endRefreshingIfNeeded()
        case let .fetchMyCommunities(model):
            myCommunities = model
            endRefreshingIfNeeded()
        case let .fetchMyCommunititesFailed(error):
            print(error)
            endRefreshingIfNeeded()
        }
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
