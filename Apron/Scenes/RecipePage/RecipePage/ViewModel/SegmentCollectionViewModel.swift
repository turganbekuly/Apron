//
//  SegmentCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.01.2022.
//

import DesignSystem
import UIKit

public protocol ISegmentCollectionViewModel {
    var title: NSAttributedString? { get }
}

public struct SegmentCollectionViewModel: ISegmentCollectionViewModel {

    // MARK: - Init

    public let name: String

    public var title: NSAttributedString? {
        Typography.regular14(
            text: name,
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    public init(name: String) {
        self.name = name
    }

}

