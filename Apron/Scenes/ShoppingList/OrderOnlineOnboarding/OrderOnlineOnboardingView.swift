//
//  OrderOnlineOnboardingView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 21.08.2023.
//

import UIKit

final class OrderOnlineOnboardingView: UICollectionView {

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
//        isPagingEnabled = true
        isScrollEnabled = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        [
            OrderOnlineOnboardingCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }
}

