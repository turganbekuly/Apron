//
//  ViewController+Extension.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.06.2022.
//

import APRUIKit
import Storages

extension ViewController {
    func handleAuthorizationStatus(completion: @escaping (() -> Void)) {
        if AuthStorage.shared.isUserAuthorized {
            completion()
        } else {
            let vc = UINavigationController(rootViewController: AuthorizationBuilder(state: .initial).build())
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }
    }
}
