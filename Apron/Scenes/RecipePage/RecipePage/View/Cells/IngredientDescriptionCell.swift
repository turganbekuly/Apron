//
//  IngredientDescriptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.02.2022.
//

import UIKit
import DesignSystem

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
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var timingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.recipeCookingTimeIcon.image
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var timingLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = Assets.gray.color
        label.textAlignment = .left
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray2.color
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [descriptionLabel, timingImageView, timingLabel, separatorView].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        timingImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.5)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(17.5)
        }

        timingLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.5)
            $0.leading.equalTo(timingImageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(separatorView.snp.top).offset(-13)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: IIngredientsDescriptionCellViewModel) {
        self.descriptionLabel.text = viewModel.description
        self.timingLabel.text = viewModel.cookingTime
    }
}
