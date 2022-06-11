//
//  AddSavedRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.06.2022.
//

import UIKit
import APRUIKit

final class AddsavedRecipeCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            selectionHandler(isSelected: isSelected)
        }
    }

    // MARK: - Views factory

    private lazy var savedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.cmntImageview.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var overlayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.alpha = 0.25
        view.isHidden = true
        return view
    }()

    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .yellow
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            savedImageView,
            recipeNameLabel
        )
        savedImageView.addSubviews(overlayView, checkmarkImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        savedImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(163)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(savedImageView.snp.bottom).offset(4)
            $0.leading.bottom.trailing.equalToSuperview()
        }

        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        checkmarkImageView.snp.makeConstraints {
            $0.center.equalTo(overlayView)
            $0.size.equalTo(30)
        }
    }

    // MARK: - Private Method

    private func selectionHandler(isSelected: Bool) {
        guard isSelected else {
            overlayView.isHidden = true
            checkmarkImageView.isHidden = true
            return
        }
        overlayView.isHidden = false
        checkmarkImageView.isHidden = false
        checkmarkImageView.bringSubviewToFront(overlayView)
    }

    // MARK: - Public Method

    func configure(with viewModel: SavedRecipeCellViewModelProtocol) {
        savedImageView.kf.setImage(
            with: URL(string: viewModel.image ?? ""),
            placeholder: ApronAssets.iconPlaceholderItem.image
        )
        recipeNameLabel.text = viewModel.name ?? ""
    }
}
