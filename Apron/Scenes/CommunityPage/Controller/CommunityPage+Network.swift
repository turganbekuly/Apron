//
//  CommunityPage+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension CommunityPageViewController {
    
    // MARK: - Network

    func getCommunities(by id: Int) {
        interactor.getCommunity(request: .init(id: id))
    }

    func joinCommunity(with id: Int) {
        interactor.joinCommunity(request: .init(id: id))
    }
}
