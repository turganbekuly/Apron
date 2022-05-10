//
//  CommunityCreationNamingCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import DesignSystem

protocol CommunityNamingCellDelegate: AnyObject {
    func cell(_ cell: CommunityCreationNamingCell, didEnteredName name: String?)
}

final class CommunityCreationNamingCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: CommunityNamingCellDelegate?

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
        label.text = "Название сообществаa"
        return label
    }()

    private lazy var roudedTextField: RoundedTextField = {
        let textField = RoundedTextField(
            placeholder: ""
        )
        textField.textField.addTarget(self, action: #selector(didEnterName(_:)), for: .editingChanged)
        return textField
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        [sectionTitleLabel, roudedTextField].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        roudedTextField.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func didEnterName(_ sender: UITextField) {
        delegate?.cell(self, didEnteredName: sender.text)
    }

    // MARK: - Public methods

    func configure(recipeName: String?) {
        roudedTextField.textField.text = recipeName ?? ""
    }
}

