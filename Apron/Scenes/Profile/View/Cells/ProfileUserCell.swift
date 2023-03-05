//
//  ProfileUserCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.07.2022.
//

import APRUIKit
import UIKit

public protocol ProfileUserCellDelegate: AnyObject {
    func cell(_ cell: UITableViewCell, didTappedAvatar avatar: UIImageView)
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
        let view = UIImageView(image: ApronAssets.user.image)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedAvatar(_:))))
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
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

    @objc
    private func didTappedAvatar(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }

        delegate?.cell(self, didTappedAvatar: imageView)
    }

    public func configure(with viewModel: ProfileUserCellProtocol) {
        usernameLabel.attributedText = viewModel.username
        emailLabel.attributedText = viewModel.email

        configureColors()
    }

    private func configureViews() {
        selectionStyle = .none
        [usernameLabel, emailLabel, userImageView, separatorView].forEach {
            contentView.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(userImageView.snp.leading).offset(-38.67)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(userImageView.snp.leading).offset(-38.67)
        }
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15.67)
            make.trailing.equalToSuperview().inset(22.67)
            make.size.equalTo(CGSize(width: 66.67, height: 66.67))
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(31.67)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        emailLabel.textColor = ApronAssets.gray.color
        usernameLabel.textColor = .black
        userImageView.tintColor = ApronAssets.lightGray.color
    }

}
