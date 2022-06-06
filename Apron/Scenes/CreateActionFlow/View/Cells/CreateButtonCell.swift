//
//  CreateButtonCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.05.2022.
//

import UIKit
import DesignSystem

final class CreateButtonCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.numberOfLines = 0
        label.textColor = ApronAssets.lightGray.color
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [iconImageView, stackView].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.top)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure(with viewModel: CreateButtonCellViewModelProtocol) {
        iconImageView.image = viewModel.image
        stackView.removeAllArrangedSubviews()
        titleLabel.text = viewModel.title
        stackView.addArrangedSubview(titleLabel)
        if let subtitle = viewModel.subtitle {
            subtitleLabel.text = subtitle
            stackView.addArrangedSubview(subtitleLabel)
        }
        stackView.layoutIfNeeded()
    }
}
