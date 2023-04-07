//
//  RecipeInstructionsViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.03.2022.
//

import UIKit
import APRUIKit
import SnapKit
import Extensions
import Models
import HapticTouch

final class RecipeInstructionsViewCell: UITableViewCell {
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

    private weak var newInstructionDelegate: AddInstructionCellTappedDelegate?
    private var instructions: [RecipeInstruction] = [] {
        didSet {
            instructionsSections = [.init(section: .instructions, rows: instructions.compactMap { .instruction($0) })]
            instructionsView.reloadData()
        }
    }

    var onCookModeTapped: (() -> Void)?

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

    lazy var instructionsView: RecipePageInstructionsView = {
        let view = RecipePageInstructionsView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    private lazy var cookModeButton: NavigationButton = {
        let button = NavigationButton()
        button.setImage(APRAssets.recipePlayIcon.image.withTintColor(APRAssets.primaryTextMain.color), for: .normal)
        button.setImage(APRAssets.recipePlayIcon.image.withTintColor(APRAssets.gray.color), for: .highlighted)
        button.backgroundType = .clearBackground
        button.isImageVisible = true
        button.setTitle(L10n.Recipe.Cook.StepByStep.title.uppercased(), for: .normal)
        button.setTitleColor(APRAssets.primaryTextMain.color, for: .normal)
        button.addTarget(self, action: #selector(cookModeTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [instructionsTitleLabel, instructionsView, cookModeButton].forEach { contentView.addSubviews($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        instructionsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }

        cookModeButton.snp.makeConstraints {
            $0.top.equalTo(instructionsTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        instructionsView.snp.makeConstraints {
            $0.top.equalTo(cookModeButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func cookModeTapped() {
        HapticTouch.generateSuccess()
        onCookModeTapped?()
    }

    // MARK: - Public methods

    func configure(with viewModel: InstructionCellViewModel) {
        instructionsTitleLabel.text = L10n.Recipe.instructions
        self.instructions = viewModel.instructions
    }
}
