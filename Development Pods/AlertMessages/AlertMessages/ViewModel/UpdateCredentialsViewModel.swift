//
//  UpdateCredentialsViewModel.swift
//  AlertMessages
//
//  Created by Akarys Turganbekuly on 08.02.2023.
//

import UIKit
import APRUIKit

public struct UpdateCredentialsViewModel: MessageProtocol {
    // MARK: - Properties

    private let titleText: String
    private let subtitleText: String
    private let firstButtonTitleText: String
    private let secondButtonTitleText: String

    public var icon: UIImage? {
        nil
    }

    public var title: NSAttributedString? {
        Typography.semibold18(text: titleText).styled
    }

    public var subtitle: NSAttributedString? {
        Typography.medium16(text: subtitleText).styled
    }

    public var firstButtonTitle: NSAttributedString? {
        Typography.semibold14(text: firstButtonTitleText, color: .white).styled
    }

    public var secondButtonTitle: NSAttributedString? {
        Typography.semibold14(text: secondButtonTitleText, color: .black).styled
    }

    public var backgroundColor: UIColor {
        .white
    }

    public var titleColor: UIColor {
        ApronAssets.primaryTextMain.color
    }

    public var subtitleColor: UIColor? {
        ApronAssets.primaryTextMain.color
    }

    public var iconColor: UIColor? {
        nil
    }

    // MARK: - Init

    public init(title: String, subtitle: String, firstButtonTitle: String, secondButtonTitle: String) {
        titleText = title
        subtitleText = subtitle
        firstButtonTitleText = firstButtonTitle
        secondButtonTitleText = secondButtonTitle
    }
}
