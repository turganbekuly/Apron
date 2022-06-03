//
//  CommunityPage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Foundation
import UIKit
import Storages
import Models

extension CommunityPageViewController: ICommunityInfoCell {
    func inviteButtonTapped() {
        //
    }

    func navigateToAuth() {
        guard AuthStorage.shared.isUserAuthorized else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
            return
        }
    }

    func joinButtonTapped(with id: Int) {
        joinCommunity(with: id)
    }
}

extension CommunityPageViewController: SearchBarProtocol {
    func searchBarDidTap() {
        guard let community = community else { return }
        let viewController = UINavigationController(
            rootViewController: GeneralSearchBuilder(
                state: .initial(.main)
            ).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}
