//
//  UpdateUsername+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.03.2023.
//

import Foundation
import Models
import Storages
import APRUIKit

extension UpdateUsernameViewController {
    enum State {
    case initial
    case updateProfileSucceed(UserUpdateResponse)
    case updateProfileFailed
    }

    func updateState() {
        switch state {
        case .initial:
            break
        case let .updateProfileSucceed(model):
            switch model.operationResult {
            case .success:
                AuthStorage.shared.username = "User"
                hideLoader()
                dismiss(animated: true) {
                    self.completion(true)
                }
            case .error:
                break
            case .exists:
                NotificationBannerManager.shared.show(
                    style: .information,
                    text: "Такое имя уже существует, пожалуйста, введите другое"
                )
            default:
                break
            }
        case .updateProfileFailed:
            print("error")
        }
    }
}
