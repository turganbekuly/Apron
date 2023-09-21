//
//  SBICollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit
import APRUIKit

final class SBICollectionView: UICollectionView {
    // MARK: - Init

    public init() {
        let layout: CollectionViewLeftAlignLayout = {
            let layout = CollectionViewLeftAlignLayout()
            layout.minimumInteritemSpacing = 8
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

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configure() {
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        [
            SBIMainCollectionCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}

