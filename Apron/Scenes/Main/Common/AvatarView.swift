//
//  AvatarView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import UIKit
import APRUIKit
import Storages
import Models

final class AvatarView: View {
    // MARK: - Private properties

    private var userStorage: UserStorageProtocol = UserStorage()
    private let provider = AKNetworkProvider<ProfileEndpoint>()

    // MARK: - Public properties

    var onTap: (() -> Void)?

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = APRAssets.user.image
        imageView.tintColor = APRAssets.primaryTextMain.color
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17.5
        return imageView
    }()

    // MARK: - Setup Views

    override func setupViews() {
        super.setupViews()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onProfileTapped))
        imageView.addGestureRecognizer(tapGR)
        addSubview(imageView)
        guard let image = userStorage.user?.image else {
            getAvatarImage(completion: { [weak self] image in
                self?.imageView.kf.setImage(
                    with: URL(string: image ?? ""),
                    placeholder: APRAssets.user.image
                )
            })
            return
        }
        
        imageView.kf.setImage(
            with: URL(string: image),
            placeholder: APRAssets.user.image
        )
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

// MARK: - Private endpoints

private extension AvatarView {
    private func getAvatarImage(completion: @escaping ((String?) -> Void)) {
        provider.send(target: .getProfile) { result in
            switch result {
            case let .success(json):
                if let json = User(json: json) {
                    self.userStorage.user = json
                    completion(json.image)
                }
            case .failure:
                break
            }
        }
    }
}
