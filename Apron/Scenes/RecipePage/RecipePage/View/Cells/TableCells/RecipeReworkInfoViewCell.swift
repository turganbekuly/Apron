//
//  RecipeReworkInfoViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2023.
//

import UIKit
import APRUIKit

final class RecipeReworkInfoViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var reworkInfoLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.backgroundColor = .red
        contentView.addSubview(reworkInfoLabel)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        reworkInfoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure(reworkInfo: [String]) {
        var text = "Замечания от модератора:\n"
        for (index, reason) in reworkInfo.enumerated() {
            if index == 0 {
                text += "\(index + 1) \(reason)"
            } else {
                text += "\n\(index + 1)) \(reason)"
            }
        }

        reworkInfoLabel.text = text
    }
}
