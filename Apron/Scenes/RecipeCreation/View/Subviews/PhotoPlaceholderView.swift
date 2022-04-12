//
//  PhotoPlaceholderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.04.2022.
//

import UIKit
import DesignSystem

final class PhotoPlaceholderView: UIView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray2.color
        view.layer.cornerRadius = 20
        return view
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.cameraIcon.image
        return imageView
    }()

    private lazy var photoTitle: UILabel = {
        let title = UILabel()
        title.font = TypographyFonts.regular14
        title.textColor = .black
        title.text = "Загрузить фото"
        title.textAlignment = .center
        return title
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(photoImageView, photoTitle)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        photoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-15)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(45)
        }

        photoTitle.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
