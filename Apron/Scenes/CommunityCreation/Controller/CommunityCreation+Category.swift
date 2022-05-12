//
//  CommunityCreation+Category.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import Foundation
import Models

protocol CategorySelectionProtocol: AnyObject {
    func selectedCategory(category: CommunityCategory)
}

extension CommunityCreationViewController: CategorySelectionProtocol {
    func selectedCategory(category: CommunityCategory) {
        self.communityCreation?.category = category
    }
}
