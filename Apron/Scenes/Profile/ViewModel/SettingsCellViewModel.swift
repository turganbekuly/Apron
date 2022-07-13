//
//  SettingsCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.07.2022.
//

import UIKit
import Storages
import APRUIKit
import Models

protocol SettingsCellViewModelProtocol {
    var icon: UIImage? { get }
    var arrowIcon: UIImage? { get }
    var title: NSAttributedString? { get }
}

struct SettingsCellViewModel: SettingsCellViewModelProtocol {
    typealias Row = ProfileViewController.Section.Row

    // MARK: - Properties

    private let row: Row

    var icon: UIImage? {
        switch row {
        case .about:
            return ApronAssets.aboutAppLogo.image
        case .logout:
            return ApronAssets.exit.image
        }
    }

    var arrowIcon: UIImage? {
        switch row {
        default:
            return ApronAssets.iconRightArrow.image
        }
    }

    var title: NSAttributedString? {
        var text = ""
        switch row {
        case .about:
            text = "О приложении"
        case .logout:
            text = "Выйти"
        }

        return Typography.regular16(text: text).styled
    }

    // MARK: - Init

    init(row: Row) {
        self.row = row
    }
}
