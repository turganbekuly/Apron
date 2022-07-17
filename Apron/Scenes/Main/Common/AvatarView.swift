//
//  AvatarView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import UIKit
import APRUIKit

final class AvatarView: View {
    // MARK: - Public properties

    var onTap: (() -> Void)?

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = ApronAssets.user.image
        imageView.tintColor = ApronAssets.lightGray.color
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - Setup Views

    override func setupViews() {
        super.setupViews()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(onProfileTapped))
        imageView.addGestureRecognizer(tapGR)
        addSubview(imageView)
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
