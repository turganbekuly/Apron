//
//  FiltersView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

final class FiltersView: UICollectionView {
    
    // MARK: - Initialization
    init() {
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
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configure() {
        allowsMultipleSelection = true
        contentInsetAdjustmentBehavior = .never
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        [FiltersHeaderView.self].forEach {
            register(viewClass: $0, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        }
        [
            FilterOptionCell.self,
            FilterActionButton.self
        ].forEach {
            register(cellClass: $0)
        }

        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}
