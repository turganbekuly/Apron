//
//  Main+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Foundation

extension MainViewController: JoinCommunityProtocol {
    func didTapJoinCommunity(with id: Int) {
        joinCommunity(with: id)
    }

    func navigateToCommunity(with id: Int) {
        //
    }
}
