//
//  DefaultAlertActionModel.swift
//  Pods
//
//  Created by Akarys Turganbekuly on 04.09.2022.
//

import UIKit

public struct AlertActionInfo {
    public enum ActionType {
        case normal
        case cancel
        case destructive

        public var actionStyle: UIAlertAction.Style {
            switch self {
            case .normal:
                return .default
            case .cancel:
                return .cancel
            case .destructive:
                return .destructive
            }
        }
    }

    public let title: String
    public let action: () -> Void
    public let type: AlertActionInfo.ActionType

    public init(title: String, type: AlertActionInfo.ActionType, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.type = type
    }
}
