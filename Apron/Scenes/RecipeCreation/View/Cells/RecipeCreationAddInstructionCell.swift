//
//  RecipeCreationAddInstructionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationAddInstructionCell: UITableViewCell {
    // MARK: - Private properties

    private weak var delegate: (UITableViewDelegate & UITableViewDataSource)? {
        didSet {
            ingredientsTableView.delegate = delegate
            ingredientsTableView.dataSource = delegate
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold17
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var roudedTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: "+  Добавьте шаги приготовления"
        )
        textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var ingredientsTableView: RecipeCreationInstructionsView = {
        let tableView = RecipeCreationInstructionsView()
        return tableView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        [titleLabel, roudedTextField].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        roudedTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }
    }

    // MARK: - Public methods

    func configure(delegate: (UITableViewDelegate & UITableViewDataSource)?) {
        self.delegate = delegate
        titleLabel.text = "Инструкция"
    }
}

