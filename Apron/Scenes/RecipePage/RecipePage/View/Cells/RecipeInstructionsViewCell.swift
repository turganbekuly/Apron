//
//  RecipeInstructionsViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.03.2022.
//

import UIKit
import DesignSystem
import SnapKit
import Extensions

final class RecipeInstructionsViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [instructionsTitleLabel, stackView].forEach { contentView.addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        instructionsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(instructionsTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: InstructionCellViewModel) {
        instructionsTitleLabel.text = "Инструкция"
        stackView.removeAllArrangedSubviews()
        var counter = 1
        viewModel.instructions.forEach {
            let view = InstructionView(
                counter: counter,
                description: $0
            )
            counter += 1
            stackView.addArrangedSubview(view)
        }
        stackView.layoutIfNeeded()
    }
}
