//
//  RecipeCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import UIKit

public final class RecipeCollectionView: UICollectionView {

    // MARK: - Init

    public init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = .init(top: 16, left: 0, bottom: 0, right: 0)
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
        showsVerticalScrollIndicator = false
        isScrollEnabled = false

        [RecipeCollectionCell.self].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}



