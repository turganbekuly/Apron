//
//  CommunityCreationPermissionsCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import APRUIKit
import M13Checkbox

protocol CommunityPermissionLevelProtocol: AnyObject {
    func permissionLevelSelected(isEditable: Bool)
}

final class CommunityCreationPermissionsCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: CommunityPermissionLevelProtocol?

    private var isEditable = true {
        didSet {
            delegate?.permissionLevelSelected(isEditable: isEditable)
            if isEditable {
                anyoneCheckbox.checkState = .checked
                nooneCheckbox.checkState = .unchecked
                return
            }

            nooneCheckbox.checkState = .checked
            anyoneCheckbox.checkState = .unchecked
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

    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Разрешения"
        return label
    }()

    private lazy var anyoneViewContainer = UIView()
    private lazy var nooneViewContainer = UIView()

    private lazy var anyoneLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = .black
        label.text = "Добавлять рецепты может каждый"
        label.numberOfLines = 2
        return label
    }()

    private lazy var nooneLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = .black
        label.text = "Добавлять рецепты могут только администраторы."
        label.numberOfLines = 2
        return label
    }()

    private lazy var anyoneCheckbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .circle
        checkbox.markType = .radio
        checkbox.stateChangeAnimation = .bounce(.stroke)
        checkbox.tintColor = .black
        checkbox.secondaryTintColor = .gray
        checkbox.isUserInteractionEnabled = false
        checkbox.checkState = .checked
        return checkbox
    }()

    private lazy var nooneCheckbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .circle
        checkbox.markType = .radio
        checkbox.stateChangeAnimation = .bounce(.stroke)
        checkbox.tintColor = .black
        checkbox.secondaryTintColor = .gray
        checkbox.isUserInteractionEnabled = false
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        anyoneViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAnyoneViewTapped)))
        nooneViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNooneViewTapped)))
        [
            sectionTitleLabel,
            anyoneViewContainer,
            nooneViewContainer
        ].forEach {
            contentView.addSubview($0)
        }

        [anyoneCheckbox, anyoneLabel].forEach {
            anyoneViewContainer.addSubview($0)
        }

        [nooneCheckbox, nooneLabel].forEach {
            nooneViewContainer.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        anyoneViewContainer.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }

        anyoneCheckbox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(18)
        }

        anyoneLabel.snp.makeConstraints {
            $0.centerY.equalTo(anyoneCheckbox.snp.centerY)
            $0.leading.equalTo(anyoneCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }

        nooneViewContainer.snp.makeConstraints {
            $0.top.equalTo(anyoneViewContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }

        nooneCheckbox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(18)
        }

        nooneLabel.snp.makeConstraints {
            $0.centerY.equalTo(nooneCheckbox.snp.centerY)
            $0.leading.equalTo(nooneCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func onAnyoneViewTapped() {
        isEditable = true

    }

    @objc
    private func onNooneViewTapped() {
        isEditable = false
    }

    // MARK: - Public methods

    func configure(isEdiatable: Bool = true) {
        self.isEditable = isEdiatable
    }
}
