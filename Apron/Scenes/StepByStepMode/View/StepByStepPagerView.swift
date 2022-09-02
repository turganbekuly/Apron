//
//  StepByStepPagerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.09.2022.
//

import UIKit

final class StepByStepPagerView: UICollectionView {

    // MARK: - Init

    init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            layout.scrollDirection = .horizontal
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

        configure()
    }

    required init?(coder: NSCoder) {
        nil
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    private func configure() {
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        [
            StepPagerCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}

