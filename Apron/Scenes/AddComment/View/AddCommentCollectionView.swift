//
//  AddCommentCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import APRUIKit
import UIKit

public final class AddCommentCollectionView: UICollectionView {

    // MARK: - Init

    public init() {
        let layout: CollectionViewLeftAlignLayout = {
            let layout = CollectionViewLeftAlignLayout()
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 8
            layout.scrollDirection = .vertical
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configure() {
        contentInsetAdjustmentBehavior = .never
        showsVerticalScrollIndicator = false
        allowsMultipleSelection = true
        isScrollEnabled = false
        [
            TagHeader.self
        ].forEach {
            register(
                viewClass: $0,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
            )
        }

        [TagCell.self].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}
