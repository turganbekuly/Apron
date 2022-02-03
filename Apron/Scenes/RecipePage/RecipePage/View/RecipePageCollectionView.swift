//
//  RecipePageCollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.01.2022.
//

import UIKit

final class RecipePageCollectionView: UICollectionView {

    // MARK: - Init

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
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
        allowsMultipleSelection = false
        isScrollEnabled = false
        contentInset = .init(top: 0, left: 0, bottom: 0, right: 16)
        [PagesCollectionViewCell.self].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}

