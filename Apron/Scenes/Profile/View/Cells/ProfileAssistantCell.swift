//
//  ProfileAssistantCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.09.2022.
//

import APRUIKit
import UIKit
import Storages
import HapticTouch

final class ProfileAssistantCell: UITableViewCell {
    // MARK: - Proeprties

    let recipeStorage: RecipeCreationStorageProtocol = RecipeCreationStorage()

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

    private lazy var switcher: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .touchUpInside)
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
        switcher.setOn(recipeStorage.isCookAssistEnabled, animated: false)

        configureColors()
    }

    private func configureViews() {
        selectionStyle = .none
        [cellBackgroundView].forEach {
            contentView.addSubview($0)
        }
        [iconImageView, titleLabel, switcher].forEach {
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
            make.trailing.equalTo(switcher.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
        }

        switcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }

    private func configureColors() {
        switcher.onTintColor = ApronAssets.mainAppColor.color
        backgroundColor = .clear
        cellBackgroundView.backgroundColor = .white
        iconImageView.tintColor = .black
        titleLabel.textColor = .black
    }

    // MARK: - User actions

    @objc
    private func switchStateDidChange(_ sender: UISwitch) {
        if sender.isOn {
            HapticTouch.generateSuccess()
            recipeStorage.isCookAssistEnabled = true
        } else {
            HapticTouch.generateError()
            recipeStorage.isCookAssistEnabled = false
        }
    }

}
