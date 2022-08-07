//
//  RecipeCreationInstructionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23.04.2022.
//

import UIKit
import APRUIKit
import Models

protocol RecipeCreationInstructionViewCellDelegate: AnyObject {
    func onRemoveTapped(instruction: String?)
}

final class RecipeCreationInstructionViewCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: RecipeCreationInstructionViewCellDelegate?

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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()

    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.regular14
        label.backgroundColor = ApronAssets.lightGray.color
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(ApronAssets.trashIcon.image, for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var separatorView = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
//        contentView.addSubviews(containerView)
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
        }
    }

    // MARK: - User actions

    @objc
    private func removeButtonTapped() {
        delegate?.onRemoveTapped(instruction: instructionLabel.text)
    }

    // MARK: - Methods

    func configure(instruction: String, stepCount: String) {
        instructionLabel.text = instruction
        stepLabel.text = "\(stepCount)"
    }
}
