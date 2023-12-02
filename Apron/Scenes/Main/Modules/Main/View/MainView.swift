//
//  MainView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

public final class MainView: UICollectionView {

    // MARK: - Init

    init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 13
            layout.scrollDirection = .vertical
            layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            layout.sectionHeadersPinToVisibleBounds = false
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        allowsMultipleSelection = false
        showsVerticalScrollIndicator = false
        keyboardDismissMode = .onDrag

        [
            DividerHeaderView.self
        ].forEach {
            register(
                viewClass: $0,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
            )
        }
        
        [
            AdBannerCell.self,
            RecipeSearchResultCellv2.self,
            RecipeSearchSkeletonCell.self,
            WhatToCookCell.self,
            CookNowCell.self,
            CommunityCell.self,
            SBIMainTableCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}
