//
//  PhotoPlaceholderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.04.2022.
//

import UIKit
import APRUIKit
import NVActivityIndicatorView

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
        view.backgroundColor = ApronAssets.lightGray2.color
        view.layer.cornerRadius = 20
        return view
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ApronAssets.cameraIcon.image
        return imageView
    }()

    private lazy var photoTitle: UILabel = {
        let title = UILabel()
        title.font = TypographyFonts.semibold14
        title.textColor = .black
        title.text = "Загрузить фото"
        title.textAlignment = .center
        title.sizeToFit()
        return title
    }()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(photoImageView, photoTitle, vStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(45)
        }

        photoTitle.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        vStackView.snp.makeConstraints {
            $0.top.equalTo(photoTitle.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: - Methods

    func configure() {
        vStackView.removeAllArrangedSubviews()
        let texts = [
            "Пожалуйста, используйте только свои уникальные фотографии. Формат JPG, JPEG, PNG. Размер до 20 мб",
            "Убедитесь, что вы подключены к 4G (LTE) или Wi-Fi. Через 3G фото может не загрузиться"
        ]
        for text in texts {
            let label = UILabel()
            label.font = TypographyFonts.regular12
            label.textColor = ApronAssets.gray.color
            label.text = text
            label.numberOfLines = 0
            label.textAlignment = .center
            vStackView.addArrangedSubview(label)
        }
        vStackView.setNeedsUpdateConstraints()
        vStackView.layoutIfNeeded()
    }
}
