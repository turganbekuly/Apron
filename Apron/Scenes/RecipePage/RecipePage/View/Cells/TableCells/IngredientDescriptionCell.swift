//
//  IngredientDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import UIKit
import APRUIKit

final class IngredientDescriptionCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var timingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.recipeCookingTimeIcon.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var timingLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = APRAssets.gray.color
        label.textAlignment = .center
        label.text = L10n.RecipeCreation.Recipe.CookTime.title
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = APRAssets.lightGray2.color
        return view
    }()
    
    private lazy var timingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .clear
        view.layer.borderColor = APRAssets.lightGray.color.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 15
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [descriptionLabel, timingStackView].forEach {
            contentView.addSubview($0)
        }
        
        timingStackView.addArrangedSubviews(timingLabel, timingTitleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        timingStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(80)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsDescriptionCellViewModel) {
        self.descriptionLabel.text = viewModel.description
        self.timingLabel.text = "\(viewModel.cookingTime ?? "0") \(L10n.Common.Measure.min)"
    }
}
