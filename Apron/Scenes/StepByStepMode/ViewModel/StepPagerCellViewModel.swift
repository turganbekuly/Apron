//
//  StepPagerCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.09.2022.
//

import APRUIKit
import UIKit

public protocol StepPagerCellViewModelProtocol {
    var title: NSAttributedString? { get }
}

public struct StepPagerCellViewModel: StepPagerCellViewModelProtocol {

    // MARK: - Init

    public let name: String

    public var title: NSAttributedString? {
        Typography.semibold14(
            text: name.uppercased(),
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    public init(name: String) {
        self.name = name
    }

}
