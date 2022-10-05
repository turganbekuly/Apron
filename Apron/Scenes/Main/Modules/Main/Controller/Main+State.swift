//
//  Main+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit

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
            show(type: .completeAppleSignin(
                "Здравствуйте!",
                "Напишите ваше имя для профиля",
                "Сохранить",
                "Позже"
            ))
            getMyCommunities()
            getCommunitiesByCategory()
        case .joinedCommunity:
            getMyCommunities()
            getCommunitiesByCategory()
        case .joinedCommunityFailed:
            show(type: .error(L10n.Common.errorMessage))
        case let .fetchCommunitiesByCategory(model):
            self.dynamicCommunities = model
            endRefreshingIfNeeded()
        case .fetchCommunitiesByCategoryFailed:
            show(type: .error(L10n.Common.errorMessage))
            endRefreshingIfNeeded()
        case let .fetchMyCommunities(model):
            myCommunities = model
            endRefreshingIfNeeded()
        case .fetchMyCommunititesFailed:
            show(type: .error(L10n.Common.errorMessage))
            endRefreshingIfNeeded()
        }
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
