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
import HapticTouch

extension CommunityPageViewController: ICommunityInfoCell {
    func inviteButtonTapped() {
        let viewController = UIActivityViewController(
            activityItems: [
                "Зацените сообщество \"\(community?.name ?? "")\" на Apron👀\n https://apron.ws/community/\(community?.id ?? 0)"
            ],
            applicationActivities: nil
        )

        if let popoover = viewController.popoverPresentationController {
            popoover.sourceView = view
            popoover.sourceRect = view.bounds
            popoover.permittedArrowDirections = []
        }
        HapticTouch.generateMedium()
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }

    func navigateToAuth() {
        handleAuthorizationStatus { }
    }

    func joinButtonTapped(with id: Int) {
        joinCommunity(with: id)
    }
}

extension CommunityPageViewController: SearchBarProtocol {
    func searchBarDidTap() {
        guard let _ = community else { return }
        let viewController = UINavigationController(
            rootViewController: GeneralSearchBuilder(
                state: .initial(.recipesFromCommunityPage(id: community?.id ?? 0))
            ).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}
