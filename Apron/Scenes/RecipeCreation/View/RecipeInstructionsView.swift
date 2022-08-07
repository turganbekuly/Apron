//
//  RecipeInstructionsView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.08.2022.
//

import UIKit

final class RecipeInstructionsView: UITableView {

    // MARK: - Init
    init() {
        super.init(frame: .zero, style: .plain)

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
        separatorStyle = .none
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        [
            RecipeCreationInstructionViewCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
        separatorStyle = .none
    }

}

