//
//  RecipeCreationAddInstructionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import DesignSystem

protocol AddInstructionCellTappedDelegate: AnyObject {
    func onAddInstructionTapped()
    func onRemoveInstructionTapped(index: Int)
}

final class RecipeCreationAddInstructionCell: UITableViewCell {
    // MARK: - Private properties

    private weak var newInstructionDelegate: AddInstructionCellTappedDelegate?

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
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    private lazy var instructionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        [titleLabel, roudedTextField, instructionsStackView].forEach { contentView.addSubview($0) }
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onAddInstructionTapped))
        roudedTextField.addGestureRecognizer(tapGR)
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

        instructionsStackView.snp.makeConstraints {
            $0.top.equalTo(roudedTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    // MARK: - User actions

    @objc
    private func onAddInstructionTapped() {
        newInstructionDelegate?.onAddInstructionTapped()
    }

    // MARK: - Public methods

    func configure(
        instructions: [String]?,
        newInstructionDelegate: AddInstructionCellTappedDelegate?
    ) {
        self.newInstructionDelegate = newInstructionDelegate
        titleLabel.text = "Инструкция"
        instructionsStackView.removeAllArrangedSubviews()

        guard let instructions = instructions else { return }
        var step = 1
        for instruction in instructions {
            let view = RecipeCreationInstructionView()
            view.configure(instruction: instruction, image: nil, stepCount: "\(step)")
            view.onItemDelete = { [weak self] in
                guard let self = self,
                      let index = self.instructionsStackView.arrangedSubviews.firstIndex(of: view) else { return }
                self.newInstructionDelegate?.onRemoveInstructionTapped(index: index)
            }
            step += 1
            instructionsStackView.addArrangedSubview(view)
        }
        instructionsStackView.layoutIfNeeded()
    }
}

