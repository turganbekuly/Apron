//
//  InstructionSelectionHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import UIKit
import APRUIKit

final class InstructionSelectionHeaderView: UITableViewHeaderFooterView {
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var sectionHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.backgroundColor = .clear
        [sectionHeaderLabel].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        sectionHeaderLabel.snp.makeConstraints {
            $0.bottom.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Methods

    func configure(title: String) {
        sectionHeaderLabel.text = title
    }
}


