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
import Storages

protocol JoinCommunityProtocol: AnyObject {
    func navigateToFromButtonCommunity(with id: Int)
    func didTapJoinCommunity(with id: Int)
    func navigateToAuth()
}

final class MainCommunityCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: JoinCommunityProtocol?
    var isJoined: Bool = false {
        didSet {
            configureButton(isJoined: isJoined)
        }
    }
    var id = 0

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
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var joinButton: BlackOpButton = {
        let button = BlackOpButton()
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
        configureCell()
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

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityCollectionCellViewModel) {
        guard let community = viewModel.community else { return }
        id = community.id
        imageView.kf.setImage(
            with: URL(string: community.image ?? ""),
            placeholder: Assets.iconPlaceholderCard.image
        )
        communityNameLabel.text = community.name ?? ""
        recipeCountLabel.text = "\(community.recipesCount ?? 0)"
        membersCountLabel.text = "\(community.usersCount ?? 0)"
        isJoined = community.joined ?? false
    }

    // MARK: - Private methods

    private func configureButton(isJoined: Bool) {
        guard isJoined else {
            joinButton.setTitle("Вступить", for: .normal)
            joinButton.snp.updateConstraints( {
                $0.width.equalTo(93)
            })
            return
        }
        joinButton.setTitle("Уже вступили", for: .normal)
        joinButton.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.equalTo(129)
        }
    }

    // MARK: - User actions

    @objc
    private func joinButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            delegate?.navigateToAuth()
            return
        }
        
        if isJoined {
            delegate?.navigateToFromButtonCommunity(with: id)
            return
        }
        HapticTouch.generateSuccess()
        joinButton.setTitle("Уже вступили", for: .normal)
        joinButton.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.equalTo(129)
        }
        layoutIfNeeded()
        delegate?.didTapJoinCommunity(with: id)
    }
}
