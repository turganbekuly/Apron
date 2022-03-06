//
//  RecipeCaloriesViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//


import UIKit
import DesignSystem

final class RecipeCaloriesViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var scaleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var calPerServingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        setupConstraints()
    }

    private func setupConstraints() {

    }

    // MARK: - Public methods

    func configure() {

    }
}
