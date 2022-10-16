//
//  RecipeSearchResultTopView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.10.2022.
//

import UIKit
import APRUIKit

final class RecipeSearchResultTopView: View {
    // MARK: - Views factory

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var cookTimeOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.1
        return view
    }()

    private lazy var cookTimeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .white
        return label
    }()

    // MARK: - Setup views

    override func setupViews() {
        super.setupViews()

        addSubview(recipeImageView)
        recipeImageView.addSubviews(cookTimeOverlayView, cookTimeLabel)
    }

    override func setupConstraints() {
        super.setupConstraints()

        recipeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cookTimeOverlayView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }

        cookTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(cookTimeOverlayView.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: RecipeSearchResultTopViewModelProtocol) {
        recipeImageView.kf.setImage(
            with: URL(string: viewModel.recipeImage ?? ""),
            placeholder: ApronAssets.iconPlaceholderItem.image
        )

        cookTimeLabel.text = viewModel.cookTime
    }
}
