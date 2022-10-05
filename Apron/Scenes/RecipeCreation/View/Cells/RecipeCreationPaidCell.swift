//
//  RecipeCreationPaidCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import UIKit
import APRUIKit

final class RecipeCreationPaidCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    // MARK: - Setup Views

    private func setupViews() {
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure() {

    }
}
