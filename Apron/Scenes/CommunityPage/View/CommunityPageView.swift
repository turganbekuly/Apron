//
//  CommunityPageView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class CommunityPageView: UICollectionView {

    // MARK: - Initialization
    init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 13
            layout.scrollDirection = .vertical
            layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
//            layout.sectionHeadersPinToVisibleBounds = true
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configure() {
        allowsMultipleSelection = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        keyboardDismissMode = .onDrag
        [
            CommunityInfoHeaderView.self,
        ].forEach {
            register(
                viewClass: $0,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
            )
        }

        [
            RecipeSearchResultCellv2.self,
            RecipeSearchSkeletonCell.self,
        ].forEach {
            register(cellClass: $0)
        }

        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}
