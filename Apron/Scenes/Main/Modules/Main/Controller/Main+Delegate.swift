//
//  Main+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Foundation
import UIKit
import Storages

extension MainViewController: JoinCommunityProtocol {
    func didTapJoinCommunity(with id: Int) {
        guard AuthStorage.shared.isUserAuthorized else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
            return
        }
        
        joinCommunity(with: id)
    }

    func navigateToFromButtonCommunity(with id: Int) {
        guard AuthStorage.shared.isUserAuthorized else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
            return
        }
    }

    func navigateToAuth() {
        guard AuthStorage.shared.isUserAuthorized else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
            return
        }
    }
}
