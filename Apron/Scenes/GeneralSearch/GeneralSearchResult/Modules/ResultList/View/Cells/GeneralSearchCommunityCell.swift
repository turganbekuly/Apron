//
//  GeneralSearchCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import APRUIKit
import HapticTouch
import Storages

protocol GeneralSearchJoinCommunityProtocol: AnyObject {
    func navigateToFromButtonCommunity(with id: Int)
    func didTapJoinCommunity(with id: Int)
    func navigateToAuth()
}

final class GeneralSearchCommunityCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: GeneralSearchJoinCommunityProtocol?

    var isJoined: Bool = false {
        didSet {
            configureButton(isJoined: isJoined)
        }
    }

    var id = 0

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var communityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var recipeImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.cmntRecipeIcon.image
        return imageView
    }()

    private lazy var recipeCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = APRAssets.gray.color
        return label
    }()

    private lazy var membersImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.cmntMemberIcon.image
        return imageView
    }()

    private lazy var membersCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = APRAssets.gray.color
        return label
    }()

    private lazy var recipeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeImageIcon, recipeCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    private lazy var membersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [membersImageIcon, membersCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeStackView, membersStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [communityImageView,
         communityNameLabel,
         joinButton,
         informationStackView
        ].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        communityImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.equalTo(56)
            $0.bottom.equalToSuperview()
        }

        joinButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(communityImageView.snp.centerY)
            $0.height.equalTo(34)
            $0.width.equalTo(93)
        }

        communityNameLabel.snp.makeConstraints {
            $0.top.equalTo(communityImageView.snp.top).offset(4)
            $0.leading.equalTo(communityImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(joinButton.snp.leading).offset(-14)
        }

        informationStackView.snp.makeConstraints {
            $0.top.equalTo(communityNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(communityImageView.snp.trailing).offset(14)
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
        isJoined = true
        layoutIfNeeded()
        delegate?.didTapJoinCommunity(with: id)
    }

    // MARK: - Private methods

    private func configureButton(isJoined: Bool) {
        guard isJoined else {
            joinButton.setTitle("Вступить", for: .normal)
            joinButton.setBackgroundColor(.black, for: .normal)
            joinButton.setTitleColor(.white, for: .normal)
            joinButton.snp.updateConstraints({
                $0.width.equalTo(93)
            })
            return
        }
        joinButton.setTitle("Уже вступили", for: .normal)
        joinButton.setBackgroundColor(APRAssets.colorsYello.color, for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.equalTo(129)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: GeneralSearchCommunityViewModelProtocol) {
        guard let community = viewModel.community else { return }
        id = community.id
        communityImageView.kf.setImage(
            with: URL(string: community.image ?? ""),
            placeholder: APRAssets.addedImagePlaceholder.image
        )

        communityNameLabel.text = community.name ?? ""
        recipeCountLabel.text = "\(community.recipesCount ?? 0)"
        membersCountLabel.text = "\(community.usersCount ?? 0)"
        informationStackView.layoutIfNeeded()
        isJoined = community.joined ?? false
    }
}
