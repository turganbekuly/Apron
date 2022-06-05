//
//  Main+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Foundation
import UIKit
import Storages
import Models

extension MainViewController: JoinCommunityProtocol {
    func didTapJoinCommunity(with id: Int) {
        handleAuthorizationStatus {
            self.joinCommunity(with: id)
        }
    }

    func navigateToFromButtonCommunity(with id: Int) {
        handleAuthorizationStatus {
            let vc = CommunityPageBuilder(state: .initial(id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func navigateToAuth() {
        handleAuthorizationStatus { }
    }
}
