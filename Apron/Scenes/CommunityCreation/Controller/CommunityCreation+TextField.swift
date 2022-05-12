//
//  CommunityCreation+TextField.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import Foundation

extension CommunityCreationViewController: CommunityNamingCellDelegate {
    func cell(_ cell: CommunityCreationNamingCell, didEnteredName name: String?) {
        self.communityCreation?.communityName = name
    }
}

extension CommunityCreationViewController: CommunityDescriptionCellDelegate {
    func cell(_ cell: CommunityCreationDescriptionCell, didEnteredDesc descr: String?) {
        self.communityCreation?.description = descr
    }
}
