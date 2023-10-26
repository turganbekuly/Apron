//
//  Profile+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.07.2022.
//

import Foundation
import UIKit

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
