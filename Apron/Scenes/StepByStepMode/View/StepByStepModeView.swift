//
//  StepByStepModeView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class StepByStepModeView: UICollectionView {

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()

    // MARK: - Init

    init() {

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
        isPagingEnabled = true
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        [
            StepDescriptionCell.self,
            StepFinalStepCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}
