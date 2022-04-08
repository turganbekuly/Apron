//
//  RecipeCreationIngredientsView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.04.2022.
//

import UIKit

final class RecipeCreationIngredientsView: UITableView {

    // MARK: - Initialization
    init() {
        super.init(frame: .zero, style: .plain)

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
        separatorStyle = .none

        [
        ].forEach {
            register(cellClass: $0)
        }

        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

