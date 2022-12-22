//
//  ProfileItemsCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.07.2022.
//

import APRUIKit
import UIKit

protocol ProfileItemsCellViewModelProtocol {
    var icon: UIImage? { get }
    var title: NSAttributedString? { get }
    var cornerRarius: CGFloat { get }
    var maskedCorners: CACornerMask { get }
}

struct ProfileItemsCellViewModel: ProfileItemsCellViewModelProtocol {

    typealias Row = ProfileViewController.Section.Row

    enum ProfileCellMode {
        case top
        case center
        case bottom
        case universal
    }

    // MARK: - Properties

    private let row: Row
    private let mode: ProfileCellMode

    public var icon: UIImage? {
        switch row {
        case .assistant:
            return ApronAssets.cookAssistant.image
        case .deleteAccount:
            return ApronAssets.profileDeleteAccount.image
        case .logout:
            return ApronAssets.exit.image
        case .user:
            return nil
        }
    }

    public var title: NSAttributedString? {
        var title = ""
        switch row {
        case .assistant:
            title = "Голосовой ассистент"
        case .deleteAccount:
            title = "Удалить аккаунт"
        case .logout:
            title = "Выйти"
        case .user:
            return nil
        }
        return Typography.regular16(text: title).styled
    }

    public var maskedCorners: CACornerMask {
        switch mode {
        case .top:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .center:
            return []
        case .bottom:
            return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .universal:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }

    public var cornerRarius: CGFloat {
        switch mode {
        case .top, .bottom, .universal:
            return 8
        case .center:
            return 0
        }
    }

    // MARK: - Init

    public init(row: Row, mode: ProfileCellMode) {
        self.row = row
        self.mode = mode
    }
}

