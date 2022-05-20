//
//  CommunitiesList+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension CommunitiesListViewController {
    
    // MARK: - Network

    func getCommunities(with id: Int, currentPage: Int) {
        interactor.getCommunities(request: .init(pageNumber: currentPage, id: id))
    }
}
