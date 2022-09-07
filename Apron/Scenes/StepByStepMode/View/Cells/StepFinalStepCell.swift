//
//  StepFinalStepCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.08.2022.
//

import UIKit
import APRUIKit

protocol StepFinalStepCellProtocol: AnyObject {
    func addCommentTapped()
}

final class StepFinalStepCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: StepFinalStepCellProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var addCommentButtom: StepStickyBottomButton = {
        let button = StepStickyBottomButton()
        button.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(addCommentTapped)
            )
        )
        return button
    }()
    

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(imageView, addCommentButtom)
        addCommentButtom.configure(with: .addComment)
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(contentView.bounds.width - 16)
        }

        addCommentButtom.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
            $0.width.equalTo(170)
        }
    }

    // MARK: - User actions

    @objc
    private func addCommentTapped() {
        delegate?.addCommentTapped()
    }

    // MARK: - Methods

    func configure(with image: String?) {
        imageView.kf.setImage(
            with: URL(string: image ?? ""),
            placeholder: ApronAssets.iconPlaceholderCard.image
        )
    }
}
