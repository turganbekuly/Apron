//
//  CommunitiesList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CommunitiesListViewController {
    
    // MARK: - State
    public enum State {
        case initial(CommunitiesListInitialState)
        case fetchCommunities([CommunityResponse])
        case fetchCommunitiesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
        case let .fetchCommunities(model):
            updateList(with: model)
        case let .fetchCommunitiesFailed(error):
            print(error)
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
