//
//  MealPlannerCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit

public final class MealPlannerCollectionView: UICollectionView {

    // MARK: - Init

    public init() {
        let layout: CollectionViewLeftAlignLayout = {
            let layout = CollectionViewLeftAlignLayout()
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 13
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
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
        showsHorizontalScrollIndicator = false
        [
            MealPlannerCollectionCell.self,
            CookNowEmptyCollectionCell.self
        ].forEach {
            register(cellClass: $0)
        }

        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}
