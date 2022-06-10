//
//  SegmentCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.05.2022.
//

import APRUIKit
import UIKit

public protocol SegmentCellViewModelProtocol {
    var title: NSAttributedString? { get }
}

public struct SegmentCellViewModel: SegmentCellViewModelProtocol {

    // MARK: - Init
    public let name: String

    public var title: NSAttributedString? {
        return Typography.semibold16(text: name.uppercased(),
                                     textAlignment: .center).styled
    }

    // MARK: - Init
    public init(name: String) {
        self.name = name
    }

}

