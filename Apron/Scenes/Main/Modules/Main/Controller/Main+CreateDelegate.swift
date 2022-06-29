//
//  Main+CreateDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.05.2022.
//

import UIKit
import APRUIKit
import Models

extension MainViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .privateCommunity:
            let vc = CommunityCreationBuilder(state: .initial(
                .create(CommunityCreation(), .privateButton))
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .publicCommunity:
            let vc = CommunityCreationBuilder(state: .initial(
                .create(CommunityCreation(), .publicButton))
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .aboutCommunities:
            break
        default:
            break
        }
    }
}
