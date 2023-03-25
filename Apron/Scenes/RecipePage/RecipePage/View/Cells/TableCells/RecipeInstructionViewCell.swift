//
//  RecipeInstructionViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.08.2022.
//

import UIKit
import APRUIKit
import Models
import GrowingTextView
import SnapKit

protocol RecipeInstructionViewCellCellDelegate: AnyObject {
    func onRemoveTapped(instruction: String?)
}

final class RecipeInstructionViewCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: RecipeInstructionViewCellCellDelegate?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.regular14
        label.backgroundColor = APRAssets.lightGray.color
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var separatorView = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear

        [instructionLabel, stepLabel, separatorView].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        stepLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview()
            $0.size.equalTo(20)
        }

        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(stepLabel.snp.trailing).offset(8)
            $0.bottom.equalTo(separatorView.snp.top).offset(-8)
        }
    }

    // MARK: - Methods

    func configure(instruction: RecipeInstruction, stepCount: String) {
        instructionLabel.text = instruction.description
        stepLabel.text = "\(stepCount)"
    }
}
