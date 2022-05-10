//
//  CommunityPage+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Foundation

extension CommunityPageViewController: ICommunityInfoCell {
    func joinButtonTapped(with id: Int) {
        joinCommunity(with: id)
    }
}
