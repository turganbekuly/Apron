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
            self.getCommunities(with: id, currentPage: currentPage)
        case let .fetchCommunities(model):
            mainView.finishInfiniteScroll { [weak self] _ in
                guard let self = self else { return }
                self.currentPage += 1
                self.add(items: model, animation: .fade)
            }
        case let .fetchCommunitiesFailed(error):
            print(error)
        }
    }
    
}
