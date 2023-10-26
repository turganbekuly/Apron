//
//  EditProfile+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit
import Storages
import Configurations
import APRUIKit
import HapticTouch

protocol EditProfileResultProtocol: AnyObject {
    func updateProfile()
}

extension EditProfileViewController {
    
    // MARK: - State
    public enum State {
        case initial(EditProfileResultProtocol)
        case profileDidUpdate
        case profileFailedUpdate(error: AKNetworkError)
        case uploadImageSucceed(String)
        case uploadImageFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(delegate):
            self.delegate = delegate
        case .profileDidUpdate:
            hideLoader()
            userStorage.user = editingUser
            ApronAnalytics.shared.setupUserInfo(
                id: userStorage.user?.id,
                name: userStorage.user?.username,
                email: userStorage.user?.email
            )
            ApronAnalytics.shared.sendAnalyticsEvent(.profileEdited)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.updateProfile()
            }
        case .profileFailedUpdate:
            show(type: .error(L10n.Alert.errorMessage))
        case let .uploadImageSucceed(path):
            if let username = nicknameTextField.textField.text {
                editingUser.username = username
            }
            editingUser.image = Configurations.downloadImageURL(imagePath: path)
            editingUser.email = userStorage.user?.email
            updateProfile(with: editingUser)
        case .uploadImageFailed:
            HapticTouch.generateError()
            show(type: .error(L10n.Alert.errorMessage))
        }
    }
    
}
