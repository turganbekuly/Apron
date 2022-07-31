//
//  CommunityCreationPrivacyCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import APRUIKit
import M13Checkbox

protocol CommunityPrivacyLevelProtocol: AnyObject {
    func privacyLevelSelected(isHidden: Bool)
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

    private var isCommunityHidden = false {
        didSet {
            delegate?.privacyLevelSelected(isHidden: isCommunityHidden)
            if isCommunityHidden {
                publicCheckbox.checkState = .unchecked
                privateCheckbox.checkState = .checked
                return
            }

            privateCheckbox.checkState = .unchecked
            publicCheckbox.checkState = .checked
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

    private lazy var publicViewContainer = UIView()
    private lazy var privateViewContainer = UIView()

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
        checkbox.checkState = .checked
        checkbox.isUserInteractionEnabled = false
        return checkbox
    }()

    private lazy var privateCheckbox: M13Checkbox = {
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

        publicViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPublicViewTapped)))
        privateViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPrivateViewTapped)))

        [
            sectionTitleLabel,
            publicViewContainer,
            privateViewContainer
        ].forEach {
            contentView.addSubview($0)
        }

        [publicCheckbox, publicLabel].forEach {
            publicViewContainer.addSubview($0)
        }

        [privateCheckbox, privateLabel].forEach {
            privateViewContainer.addSubview($0)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        publicViewContainer.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }

        publicCheckbox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(18)
        }

        publicLabel.snp.makeConstraints {
            $0.centerY.equalTo(publicCheckbox.snp.centerY)
            $0.leading.equalTo(publicCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }

        privateViewContainer.snp.makeConstraints {
            $0.top.equalTo(publicViewContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }

        privateCheckbox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(18)
        }

        privateLabel.snp.makeConstraints {
            $0.centerY.equalTo(privateCheckbox.snp.centerY)
            $0.leading.equalTo(privateCheckbox.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func onPublicViewTapped() {
        isCommunityHidden = false
    }

    @objc
    private func onPrivateViewTapped() {
        isCommunityHidden = true
    }

    // MARK: - Public methods

    func configure(isHidden: Bool) {
        self.isCommunityHidden = isHidden
    }
}
