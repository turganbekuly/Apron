//
//  CommunityCreation+Privacy.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import Foundation

extension CommunityCreationViewController: CommunityPrivacyLevelProtocol {
    func privacyLevelSelected(isHidden: Bool) {
        self.communityCreation?.isHidden = isHidden
    }
}

extension CommunityCreationViewController: CommunityPermissionLevelProtocol {
    func permissionLevelSelected(isEditable: Bool) {
        self.communityCreation?.privateAdding = !isEditable
    }
}
