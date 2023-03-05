//
//  TagCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import Models
import APRUIKit
import UIKit

public protocol TagCellViewModelProtocol {
    var backgroundColor: UIColor? { get }
    var title: NSAttributedString? { get }
}

public struct TagCellViewModel: TagCellViewModelProtocol {

    // MARK: - Properties

    private let tag: String
    private let isSelected: Bool

    public var backgroundColor: UIColor? {
        isSelected ? ApronAssets.mainAppColor.color : .white
    }

    public var title: NSAttributedString? {
        return Typography.regular16(
            text: tag,
            color: isSelected ? .white : .black,
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    public init(tag: String, isSelected: Bool) {
        self.tag = tag
        self.isSelected = isSelected
    }

}
