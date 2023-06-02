//
//  AppTabBarViewController+Extension.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.02.2023.
//


import APRUIKit
import Storages
import AlertMessages
import Models

extension AppTabBarController: Messagable {
    func handleAuthorizationStatus(
        completion: (() -> Void)? = nil
    ) {
        let storage = AuthStorage.shared
        if storage.isUserAuthorized {
//            guard storage.username != nil, storage.username?.isEmpty == false else {
//                let viewController = UpdateUsernameViewController(state: .initial) { success in
//                    if success {
//                        completion?()
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.presentPanModal(viewController)
//                }
//                return
//            }
            completion?()
        } else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }
    }
}

