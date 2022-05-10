//
//  Main+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension MainViewController {
    
    // MARK: - Network

    func joinCommunity(with id: Int) {
        interactor.joinCommunity(request: .init(id: id))
    }
}
