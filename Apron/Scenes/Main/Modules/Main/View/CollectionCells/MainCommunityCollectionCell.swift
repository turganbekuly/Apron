//
//  MainCommunityCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import DesignSystem
import UIKit
import Kingfisher
import HapticTouch

protocol JoinCommunityProtocol: AnyObject {
    func didTapJoinCommunity(with id: Int)
}

final class MainCommunityCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: JoinCommunityProtocol?

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
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.image = Assets.cmntImageview.image
        return imageView
    }()

    private lazy var joinButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Вступить", for: .normal)
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var communityNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.cmntRecipeIcon.image
        return imageView
    }()

    private lazy var recipeCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = Assets.gray.color
        return label
    }()

    private lazy var membersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.cmntMemberIcon.image
        return imageView
    }()

    private lazy var membersCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = Assets.gray.color
        return label
    }()

    private lazy var recipeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeImageView, recipeCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    private lazy var membersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [membersImageView, membersCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [imageView, joinButton, communityNameLabel, recipeStackView, membersStackView].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        joinButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).offset(-11)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.height.equalTo(34)
            $0.width.equalTo(93)
        }

        communityNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(communityNameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        membersStackView.snp.makeConstraints {
            $0.top.equalTo(communityNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(recipeStackView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview()
        }
        
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityCollectionCellViewModel) {
        //            imageView.kf.setImage(with: viewModel.imageURL)
        if viewModel.isMyCommunity {
            joinButton.isHidden = true
        } else {
            joinButton.isHidden = false
        }
        communityNameLabel.text = viewModel.communityName
        imageView.image = viewModel.imageURL
        recipeCountLabel.text = viewModel.recipeCount
        membersCountLabel.text = viewModel.membersCount
    }

    // MARK: - User actions

    @objc
    private func joinButtonTapped() {
        HapticTouch.generateSuccess()
        joinButton.setTitle("Уже вступили", for: .normal)
        joinButton.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.equalTo(129)
        }
        layoutIfNeeded()
        delegate?.didTapJoinCommunity(with: 0)
    }
}
