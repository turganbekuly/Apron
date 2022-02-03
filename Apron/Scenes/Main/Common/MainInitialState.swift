//
//  MainInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.01.2022.
//

import Foundation

public enum MainInitialState: Equatable {
    case community
    case activity

    var title: String {
        switch self {
        case .community:
            return "Сообщества"
        case .activity:
            return "Активность"
        }
    }

    var section: String? {
        switch self {
        case .community:
            return "Сообщества"
        case .activity:
            return "Активность"
        }
    }

    public static func ==(lhs: MainInitialState, rhs: MainInitialState) -> Bool {
        switch (lhs, rhs) {
        case (.community, .community):
            return true
        case (.activity, .activity):
            return true
        default:
            return false
        }
    }
}
