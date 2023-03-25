//
//  RecipeInformationViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.01.2022.
//

import APRUIKit
import UIKit

final class RecipeInformationViewCell: UITableViewCell {
    // MARK: - Properties

    var onEditButtonTapped: (() -> Void)?
    var onShareButtonTapped: (() -> Void)?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(APRAssets.recipeLikeUnselected.image, for: .normal)
        button.setTitleColor(APRAssets.gray.color, for: .normal)
        button.setTitle("20", for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        return button
    }()

    private lazy var dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(APRAssets.gray.color, for: .normal)
        button.setTitle("2", for: .normal)
        button.setImage(APRAssets.recipeDislikeUnselected.image, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(APRAssets.recipeEditIcon.image, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(APRAssets.recipeShareIcon.image, for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var recipeSourceURLButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.black, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular12
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        isUserInteractionEnabled = true
        [
            titleLabel,
            recipeImageView,
            likeButton,
            dislikeButton,
            editButton,
            shareButton
        ].forEach { contentView.addSubview($0) }

        [recipeSourceURLButton].forEach { recipeImageView.addSubview($0) }

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        recipeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((contentView.bounds.width / 1.5))
        }

        recipeSourceURLButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(11)
            $0.height.equalTo(20)
            $0.width.greaterThanOrEqualTo(50)
        }

        likeButton.snp.makeConstraints {
            $0.top.equalTo(recipeImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }

        dislikeButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(likeButton.snp.trailing).offset(30)
            $0.height.equalTo(24)
        }

        shareButton.snp.makeConstraints {
            $0.top.equalTo(dislikeButton.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
//
//        editButton.snp.makeConstraints {
//            $0.top.equalTo(shareButton.snp.top)
//            $0.trailing.equalTo(shareButton.snp.leading).offset(-16)
//            $0.height.equalTo(24)
//        }
    }

    // MARK: - User actions

    @objc
    private func editButtonTapped() {
        onEditButtonTapped?()
    }

    @objc
    private func shareButtonTapped() {
        onShareButtonTapped?()
    }

    // MARK: - Methods

    func configure(with viewModel: IInformationCellViewModel) {
        titleLabel.text = viewModel.recipeName
        if let url = viewModel.recipeSourceURL, !url.isEmpty {
            recipeSourceURLButton.setTitle(viewModel.recipeSourceURL, for: .normal)
            recipeSourceURLButton.sizeToFit()
            recipeSourceURLButton.isHidden = false
        } else {
            recipeSourceURLButton.isHidden = true
        }
        recipeImageView.kf.setImage(
            with: URL(string: viewModel.recipeImage ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image,
            options: [.transition(.fade(0.4))]
        )
        likeButton.setTitle("\(viewModel.likeCount)", for: .normal)
        dislikeButton.setTitle("\(viewModel.dislikeCount)", for: .normal)
    }
}
