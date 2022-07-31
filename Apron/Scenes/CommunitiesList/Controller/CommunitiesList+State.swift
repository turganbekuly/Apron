//
//  CommunitiesList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit
import HapticTouch

extension CommunitiesListViewController {
    
    // MARK: - State
    public enum State {
        case initial(CommunitiesListInitialState)
        case fetchCommunities([CommunityResponse])
        case fetchCommunitiesFailed(AKNetworkError)
        case joinedCommunity
        case joinedCommunityFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
        case let .fetchCommunities(model):
            updateList(with: model.filter { $0.isHidden == false })
        case let .fetchCommunitiesFailed(error):
            print(error)
        case .joinedCommunity:
            HapticTouch.generateSuccess()
        case .joinedCommunityFailed:
            show(type: .error(L10n.Common.errorMessage))
        }
    }

    private func updateList(with communities: [CommunityResponse]) {
        if self.communities.isEmpty {
            self.communities = communities
        } else {
            self.communities.append(contentsOf: communities)
            mainView.finishInfiniteScroll()
        }
        configureCommunities()
    }

    private func configureCommunities() {
        guard let section = sections
            .firstIndex(where: { $0.section == .communities }) else { return }
        currentPage += 1
        sections[section].rows = communities.compactMap { .community($0) }
        mainView.reloadData()
    }
    
}
