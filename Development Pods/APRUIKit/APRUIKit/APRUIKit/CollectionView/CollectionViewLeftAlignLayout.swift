//
//  CollectionViewLeftAlignLayout.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import AlignedCollectionViewFlowLayout
import UIKit

public final class CollectionViewLeftAlignLayout: AlignedCollectionViewFlowLayout {

    // MARK: - Init

    override public init(horizontalAlignment: HorizontalAlignment = .left, verticalAlignment: VerticalAlignment = .center) {
        super.init(horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment)
    }

    public required init?(coder aDecoder: NSCoder) {
        nil
    }

}
