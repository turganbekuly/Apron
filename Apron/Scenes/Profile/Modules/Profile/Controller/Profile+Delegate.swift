//
//  Profile+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.07.2022.
//

import Foundation
import UIKit
import AlertMessages
import APRUIKit

extension ProfileViewController: ProfileUserCellDelegate {
    func didTapEditProfile() {
        let vc = EditProfileBuilder(state: .initial(self)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension ProfileViewController: EditProfileResultProtocol {
    func updateProfile() {
        self.mainView.reloadData()
    }
}

extension ProfileViewController: ProfileAssistantCellProtocol {
    func toggleEnabled() {
        let okAction = AlertActionInfo(
            title: L10n.Alert.Clear.buttonTitle,
            type: .normal,
            action: { }
        )
        
        showAlert(
            L10n.Profile.Assistant.Enabled.title,
            message: L10n.Profile.Assistant.Enabled.message,
            actions: [okAction]
        )
    }
}
