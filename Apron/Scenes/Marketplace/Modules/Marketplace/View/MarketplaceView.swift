//
//  MarketplaceView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

final class MarketplaceView: UICollectionView {

    // MARK: - Init

    init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 13
            layout.scrollDirection = .vertical
            layout.sectionInset = .init(top: 16, left: 16, bottom: 0, right: 16)
            layout.sectionHeadersPinToVisibleBounds = true
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configure() {
        showsVerticalScrollIndicator = false
        [

        ].forEach {
            register(
                viewClass: $0,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
            )
        }

        [
            MarketplaceItemCell.self,
            MainCommunityEmptyCollectionCell.self,
            EmptyListCollectionCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}
