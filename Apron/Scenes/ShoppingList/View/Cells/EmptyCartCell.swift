//
//  EmptyCartCell.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 05.05.2022.
//

import UIKit
import DesignSystem

final class EmptyCartCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var emptyTextLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [emptyTextLabel, emptyStateImageView].forEach { addSubview($0) }
        emptyTextLabel.text = "Добавьте товары в свой список покупок"
        emptyStateImageView.image = Assets.emptyCart.image
        setupConstraints()
    }

    private func setupConstraints() {
        emptyTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.leading.trailing.equalToSuperview().inset(80)
        }

        emptyStateImageView.snp.makeConstraints {
            $0.top.equalTo(emptyTextLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
