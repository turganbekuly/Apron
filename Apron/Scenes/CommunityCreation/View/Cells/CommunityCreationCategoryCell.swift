//
//  CommunityCreationCategoryCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import APRUIKit
import Models

final class CommunityCreationCategoryCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Категория"
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = APRAssets.gray.color
        label.font = TypographyFonts.regular12
        label.textAlignment = .left
        label.text = "Выберите категорию"
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.arrowForward.image
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubviews(containerView, sectionTitleLabel)
        containerView.addSubviews(titleLabel, arrowImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.leading.equalToSuperview().inset(16)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
    }

    // MARK: - Public methods

    func configure(with category: CommunityCategory?) {
        sectionTitleLabel.text = "Категория"
        guard let category = category else {
            titleLabel.text = "Выберите категорию"
            return
        }
        titleLabel.text = category.name
    }
}
