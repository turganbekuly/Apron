//
//  Main+CreateDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29.05.2022.
//

import UIKit
import DesignSystem
import Models

extension MainViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .privateCommunity, .publicCommunity:
            let vc = CommunityCreationBuilder(state: .initial(.create(CommunityCreation()))).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .aboutCommunities:
            print("no")
        default:
            break
        }
    }
}
