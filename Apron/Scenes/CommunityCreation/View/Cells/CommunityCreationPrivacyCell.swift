//
//  CommunityCreationPrivacyCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import DesignSystem
import M13Checkbox

protocol CommunityPrivacyLevelProtocol: AnyObject {
    func privacyLevelSelected(isPublic: Bool)
}

final class CommunityCreationPrivacyCell: UITableViewCell {
    // MARK: - Properties

    let boldAttributes = [
        NSAttributedString.Key.font: TypographyFonts.bold11,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    let regularAttributes = [
        NSAttributedString.Key.font: TypographyFonts.regular11,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    weak var delegate: CommunityPrivacyLevelProtocol?

    private var isPublic = true {
        didSet {
            delegate?.privacyLevelSelected(isPublic: isPublic)
            if isPublic {
                publicCheckbox.checkState = .checked
                privateCheckbox.checkState = .unchecked
                return
            }

            privateCheckbox.checkState = .checked
            publicCheckbox.checkState = .unchecked
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
        label.text = "Конфиденциальность"
        return label
    }()

    private lazy var publicLabel: UILabel = {
        let label = UILabel()
        let boldText = "Публичный"
        let normalText = " - Каждый может найти и присоединиться"
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        let normalString = NSMutableAttributedString(string: normalText, attributes: regularAttributes)
        attributedString.append(normalString)
        label.attributedText = attributedString
        label.numberOfLines = 2
        return label
    }()

    private lazy var privateLabel: UILabel = {
        let label = UILabel()
        let boldText = "Частный"
        let normalText = " - Не отображается при поиске, людям требуется разрешение, чтобы присоединиться"
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        let normalString = NSMutableAttributedString(string: normalText, attributes: regularAttributes)
        attributedString.append(normalString)
        label.attributedText = attributedString
        label.numberOfLines = 2
        return label
    }()

    private lazy var publicCheckbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .circle
        checkbox.markType = .radio
        checkbox.stateChangeAnimation = .bounce(.stroke)
        checkbox.tintColor = .black
        checkbox.secondaryTintColor = .gray
        checkbox.addTarget(self, action: #selector(publicCheckboxValueChanged(_:)), for: .valueChanged)
        checkbox.checkState = .checked
        return checkbox
    }()

    private lazy var privateCheckbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .circle
        checkbox.markType = .radio
        checkbox.stateChangeAnimation = .bounce(.stroke)
        checkbox.tintColor = .black
        checkbox.secondaryTintColor = .gray
        checkbox.addTarget(self, action: #selector(privateCheckboxValueChanged(_:)), for: .valueChanged)
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [
            sectionTitleLabel,
            publicLabel,
            publicCheckbox,
            privateLabel,
            privateCheckbox
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

        publicCheckbox.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(18)
        }

        publicLabel.snp.makeConstraints {
            $0.centerY.equalTo(publicCheckbox.snp.centerY)
            $0.leading.equalTo(publicCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        privateCheckbox.snp.makeConstraints {
            $0.top.equalTo(publicCheckbox.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(18)
        }

        privateLabel.snp.makeConstraints {
            $0.centerY.equalTo(privateCheckbox.snp.centerY)
            $0.leading.equalTo(privateCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - User actions

    @objc
    private func publicCheckboxValueChanged(_ sender: M13Checkbox) {
        isPublic = true
    }

    @objc
    private func privateCheckboxValueChanged(_ sender: M13Checkbox) {
        isPublic = false
    }

    // MARK: - Public methods

    func configure(isPublic: Bool = true) {
        self.isPublic = isPublic
    }
}
