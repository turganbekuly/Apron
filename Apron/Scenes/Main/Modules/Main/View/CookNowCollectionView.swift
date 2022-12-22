//
//  CookNowCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.12.2022.
//

import UIKit

public final class CookNowCollectionView: UICollectionView {

    // MARK: - Init

    public init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
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

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configure() {
        showsHorizontalScrollIndicator = false

        [
            RecipeSearchResultCell.self,
            RecipeSearchResultCellv2.self,
            RecipeSearchSkeletonCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}




