//
//  AvatarView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import UIKit
import APRUIKit
import Storages

final class AvatarView: View {
    // MARK: - Private properties

    private var userStorage: UserStorageProtocol = UserStorage()

    // MARK: - Public properties

    var onTap: (() -> Void)?

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = ApronAssets.user.image
        imageView.tintColor = ApronAssets.primaryTextMain.color
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - Setup Views

    override func setupViews() {
        super.setupViews()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onProfileTapped))
        imageView.addGestureRecognizer(tapGR)
        addSubview(imageView)

        guard userStorage.user != nil else { return }
        self.imageView.setImage(string: userStorage.user?.username ?? "User")
    }

    override func setupConstraints() {
        super.setupConstraints()

        snp.makeConstraints {
            $0.size.equalTo(35)
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func onProfileTapped() {
        onTap?()
    }
}
