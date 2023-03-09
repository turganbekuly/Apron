//
//  RecipeCreationPaidCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.10.2022.
//

import UIKit
import APRUIKit

protocol RecipeCreationPaidCellProtocol: AnyObject {
    func cell(valueChangedSwitch switcher: UISwitch)
}

final class RecipeCreationPaidCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: RecipeCreationPaidCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var getCertLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Получить подарок"
        return label
    }()

    private lazy var getCertDescrLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Добавьте к своему рецепту фотографию, а в описании рецепта укажите не менее трех шагов с фото. Для того, чтобы мы могли отправить подарок, укажите, пожалуйста, свой номер телефона."
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var switcher: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .touchUpInside)
        view.onTintColor = ApronAssets.primaryTextMain.color
        return view
    }()

    private lazy var separator = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            getCertLabel,
            getCertDescrLabel,
            switcher,
            separator
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        separator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        getCertLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(switcher.snp.leading).offset(-8)
        }

        switcher.snp.makeConstraints {
            $0.centerY.equalTo(getCertLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)

        }

        getCertDescrLabel.snp.makeConstraints {
            $0.top.equalTo(getCertLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - User actions

    @objc
    private func switchStateDidChange(_ sender: UISwitch) {
        delegate?.cell(valueChangedSwitch: sender)
    }
}
