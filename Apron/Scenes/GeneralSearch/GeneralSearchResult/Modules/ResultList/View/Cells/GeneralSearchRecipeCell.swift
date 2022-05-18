//
//  GeneralSearchRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import DesignSystem

final class GeneralSearchRecipeCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.image = Assets.cmntImageview.image
        return imageView
    }()

    private lazy var favoriteButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setImage(Assets.recipeFavoriteIcon.image, for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var sourceLinkLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = Assets.gray.color
        label.textAlignment = .left
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeNameLabel, sourceLinkLabel])
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [recipeImageView, stackView, favoriteButton].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        recipeImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(56)
        }

        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(recipeImageView.snp.centerY)
            $0.size.equalTo(38)
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalTo(recipeImageView.snp.centerY)
            $0.leading.equalTo(recipeImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(favoriteButton.snp.leading).offset(-14)
            $0.height.equalTo(56)
        }
    }

    // MARK: - User actions

    @objc
    private func favoriteButtonTapped() {
        //
    }

    // MARK: - Public methods

    func configure(with viewModel: GeneralSearchRecipeViewModelProtocol) {
        recipeImageView.kf.setImage(
            with: URL(string: viewModel.image ?? ""),
            placeholder: Assets.addedImagePlaceholder.image
        )

        recipeNameLabel.text = viewModel.name
        sourceLinkLabel.text = viewModel.sourceLink ?? ""
    }
}