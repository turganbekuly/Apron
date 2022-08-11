//
//  RecipeCreationImageCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.04.2022.
//

import UIKit
import APRUIKit

protocol RecipeCreationImageCellProtocol: AnyObject {
    func editPhoto()
    func deletePhoto()
}

final class RecipeCreationImageCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: RecipeCreationImageCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imagePlaceholder: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ApronAssets.recipeSampleImage.image
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
        button.setImage(ApronAssets.trashIcon.image, for: .normal)
        button.layer.cornerRadius = 15.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ApronAssets.colorsYello.color
        button.setImage(ApronAssets.editIcon.image, for: .normal)
        button.layer.cornerRadius = 15.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(imagePlaceholder)
        imagePlaceholder.addSubviews(deleteButton, editButton)
        setupConstraints()
    }

    private func setupConstraints() {
        imagePlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        deleteButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
            $0.size.equalTo(31)
        }

        editButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(31)
        }
    }

    // MARK: - User actions

    @objc
    private func deleteButtonTapped() {
        delegate?.deletePhoto()
    }

    @objc
    private func editButtonTapped() {
        delegate?.editPhoto()
    }

    // MARK: - Public methods

    func configure(image: UIImage?, imageURL: String?) {
//        if let image = image {
//            imagePlaceholder.image = image
//            return
//        }

        if let imageURL = imageURL {
            imagePlaceholder.kf.setImage(
                with: URL(string: imageURL),
                placeholder: ApronAssets.addedImagePlaceholder.image,
                options: [.transition(.fade(0.25))]
            )
        }
    }
}
