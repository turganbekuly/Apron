//
//  GeneralSearchResultView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

public final class GeneralSearchResultView: UICollectionView {

    // MARK: - Init
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configure() {
        allowsMultipleSelection = false
        contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        showsHorizontalScrollIndicator = false
        [SegmentItemCell.self].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}
