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

    private lazy var publicLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = .black
        label.text = "Добавлять рецепты может каждый"
        label.numberOfLines = 2
        return label
    }()

    private lazy var privateLabel: UILabel = {
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
        checkbox.addTarget(self, action: #selector(anyoneCheckboxValueChanged(_:)), for: .valueChanged)
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
        checkbox.addTarget(self, action: #selector(nooneCheckboxValueChanged(_:)), for: .valueChanged)
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [
            sectionTitleLabel,
            publicLabel,
            anyoneCheckbox,
            privateLabel,
            nooneCheckbox
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        anyoneCheckbox.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(18)
        }

        publicLabel.snp.makeConstraints {
            $0.centerY.equalTo(anyoneCheckbox.snp.centerY)
            $0.leading.equalTo(anyoneCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        nooneCheckbox.snp.makeConstraints {
            $0.top.equalTo(anyoneCheckbox.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(18)
        }

        privateLabel.snp.makeConstraints {
            $0.centerY.equalTo(nooneCheckbox.snp.centerY)
            $0.leading.equalTo(nooneCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - User actions

    @objc
    private func anyoneCheckboxValueChanged(_ sender: M13Checkbox) {
        isEditable = true

    }

    @objc
    private func nooneCheckboxValueChanged(_ sender: M13Checkbox) {
        isEditable = false
    }

    // MARK: - Public methods

    func configure(isEdiatable: Bool = true) {
        self.isEditable = isEdiatable
    }
}

