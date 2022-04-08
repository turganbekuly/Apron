//
//  RecipePageView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import UIKit

public final class RecipePageView: UITableView {

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero, style: .plain)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        separatorStyle = .none
        tableFooterView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 64)))

        [
            RecipeInformationViewCell.self,
            RecipeIngredientsViewCell.self,
            RecipeInstructionsViewCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

