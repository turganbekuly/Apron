//
//  CommunitiesList+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28.06.2022.
//

import Foundation

extension CommunitiesListViewController: GeneralSearchJoinCommunityProtocol {
    func didTapJoinCommunity(with id: Int) {
        handleAuthorizationStatus {
            self.joinCommunity(with: id)
        }
    }

    func navigateToFromButtonCommunity(with id: Int) {
        handleAuthorizationStatus {
            let vc = CommunityPageBuilder(state: .initial(.fromMain(id: id))).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func navigateToAuth() {
        handleAuthorizationStatus { }
    }
}
