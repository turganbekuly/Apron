//
//  ProfileUserCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.07.2022.
//

import APRUIKit
import UIKit

public protocol ProfileUserCellDelegate: AnyObject {
    func didTapEditProfile()
}

public final class ProfileUserCell: UITableViewCell {

    // MARK: - Properties

    public weak var delegate: ProfileUserCellDelegate?

    // MARK: - Views

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var userImageView: UIImageView = {
        let view = UIImageView(image: APRAssets.user.image)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 33.3
        return view
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: TypographyFonts.semibold17,
            .foregroundColor: APRAssets.primaryTextMain.color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        
        let attributeString = NSMutableAttributedString(
            string: "Настроить профиль",
            attributes: yourAttributes
        )
        
        button.setAttributedTitle(attributeString, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var separatorView = SeparatorView()

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    public func configure(with viewModel: ProfileUserCellProtocol) {
        usernameLabel.attributedText = viewModel.username
        emailLabel.attributedText = viewModel.email
        
        if let imageString = viewModel.imageURL,
           let url = URL(string: imageString) {
            userImageView.kf.setImage(
                with: url,
                placeholder: APRAssets.user.image
            )
        }
        configureColors()
    }

    private func configureViews() {
        selectionStyle = .none
        contentView.addSubviews(
            usernameLabel,
            emailLabel,
            userImageView,
            separatorView,
            editProfileButton
        )

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15.67)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 66.67, height: 66.67))
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-38.67)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-38.67)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.equalTo(emailLabel.snp.leading)
            $0.trailing.lessThanOrEqualTo(emailLabel.snp.trailing)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        emailLabel.textColor = APRAssets.gray.color
        usernameLabel.textColor = .black
        userImageView.tintColor = APRAssets.lightGray.color
    }

    // MARK: - User actions
    
    @objc
    private func editProfileButtonTapped() {
        delegate?.didTapEditProfile()
    }
}
