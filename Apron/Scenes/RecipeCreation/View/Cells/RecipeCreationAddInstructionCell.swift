//
//  RecipeCreationAddInstructionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.04.2022.
//

import UIKit
import APRUIKit
import Models

protocol AddInstructionCellTappedDelegate: AnyObject {
    func onAddInstructionTapped()
    func remove(instruction: RecipeInstruction)
    func onInstructionTapped(instruction: RecipeInstruction, step: Int)
}

final class RecipeCreationAddInstructionCell: UITableViewCell {
    // MARK: - Public properties

    struct InstructionsSection {
        enum Section {
            case instructions
        }
        enum Row {
            case instruction(RecipeInstruction)
        }
        var section: Section
        var rows: [Row]
    }

    lazy var instructionsSections: [InstructionsSection] = [
        .init(section: .instructions, rows: instructions.compactMap { .instruction($0) })
    ]

    // MARK: - Private properties

    weak var newInstructionDelegate: AddInstructionCellTappedDelegate?
    var instructions: [RecipeInstruction] = [] {
        didSet {
            instructionsSections = [.init(section: .instructions, rows: instructions.compactMap { .instruction($0) })]
            instructionsView.reloadData()
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
        textField.textField.isUserInteractionEnabled = false
        return textField
    }()

    lazy var instructionsView: RecipeInstructionsView = {
        let view = RecipeInstructionsView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [titleLabel, roudedTextField, instructionsView].forEach { contentView.addSubview($0) }
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
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }

        instructionsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(roudedTextField.snp.top).offset(-8)
        }
    }

    // MARK: - User actions

    @objc
    private func onAddInstructionTapped() {
        newInstructionDelegate?.onAddInstructionTapped()
    }

    // MARK: - Public methods

    func configure(instructions: [RecipeInstruction]?) {
        titleLabel.text = "Инструкция"
        guard let instructions = instructions else {
            return
        }
        self.instructions = instructions
    }
}
