//
//  RecipeCreationImageCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationImageCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imagePlaceholder: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.recipeSampleImage.image
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        button.setImage(Assets.trashIcon.image, for: .normal)
        button.layer.cornerRadius = 15.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Assets.colorsYello.color
        button.setImage(Assets.editIcon.image, for: .normal)
        button.layer.cornerRadius = 15.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(imagePlaceholder)
        imagePlaceholder.addSubviews(deleteButton, editButton)
        setupConstraints()
    }

    private func setupConstraints() {
        imagePlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        deleteButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
            $0.size.equalTo(31)
        }

        editButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(31)
        }
    }

    // MARK: - User actions

    @objc
    private func deleteButtonTapped() { }

    @objc
    private func editButtonTapped() { }

    // MARK: - Public methods

    func configure() { }
}
