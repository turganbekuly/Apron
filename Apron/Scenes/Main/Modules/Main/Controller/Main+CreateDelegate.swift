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
        var communityCreation = CommunityCreation()
        switch type {
        case .privateCommunity:
            communityCreation.isHidden = true
            let vc = CommunityCreationBuilder(state: .initial(
                .create(communityCreation, .privateButton))
            ).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .publicCommunity:
            communityCreation.isHidden = false
            let vc = CommunityCreationBuilder(state: .initial(
                .create(communityCreation, .publicButton))
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
