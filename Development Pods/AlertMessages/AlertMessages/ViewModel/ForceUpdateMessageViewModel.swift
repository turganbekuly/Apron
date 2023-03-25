//
//  ForceUpdateMessageViewModel.swift
//  AlertMessages
//
//  Created by Akarys Turganbekuly on 19.06.2022.
//

import APRUIKit
import UIKit

public struct ForceUpdateMessageViewModel: MessageProtocol {
    // MARK: - MessageProtocol

    public var icon: UIImage? {
        APRAssets.forceUpdateImage.image
    }

    public var title: NSAttributedString? {
        Typography.bold16(
            text: "Ваша версия устарела",
            color: .black,
            textAlignment: .center,
            url: nil
        ).styled
    }

    public var subtitle: NSAttributedString? {
        Typography.regular16(
            text: "Используйте актуальную версию для корректной работы приложения",
            color: .black,
            textAlignment: .center,
            url: nil
        ).styled
    }

    public var firstButtonTitle: NSAttributedString? {
        Typography.semibold16(
            text: "Обновить",
            color: .white
        ).styled
    }

    public var secondButtonTitle: NSAttributedString? {
        nil
    }

    public var backgroundColor: UIColor {
        .white
    }

    public var titleColor: UIColor {
        .black
    }

    public var subtitleColor: UIColor? {
        .black
    }

    public var iconColor: UIColor? {
        nil
    }
}
