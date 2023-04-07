//
//  ProfileItemsCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.07.2022.
//

import APRUIKit
import UIKit

final class ProfileItemsCell: UITableViewCell {

    // MARK: - Views

    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel = UILabel()

    private lazy var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = APRAssets.arrowForward.image
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    func configure(with viewModel: ProfileItemsCellViewModel) {
        iconImageView.image = viewModel.icon
        titleLabel.attributedText = viewModel.title
        cellBackgroundView.layer.maskedCorners = viewModel.maskedCorners
        cellBackgroundView.layer.cornerRadius = viewModel.cornerRarius

        configureColors()
    }

    private func configureViews() {
        selectionStyle = .none
        [cellBackgroundView].forEach {
            contentView.addSubview($0)
        }
        [iconImageView, titleLabel, arrowImageView].forEach {
            cellBackgroundView.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        cellBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(1)
        }
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
    }

    private func configureColors() {
        arrowImageView.tintColor = .black
        backgroundColor = .clear
        cellBackgroundView.backgroundColor = .white
        iconImageView.tintColor = .black
        titleLabel.textColor = .black
    }

}
