//
//  GeneralSearchCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import DesignSystem
import Kingfisher

final class GeneralSearchCommunityCell: UITableViewCell {
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
        label.font = TypographyFonts.regular14
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

    private lazy var infomartionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [communityNameLabel, consistanceStackView])
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var consistanceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeStackView, membersStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
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
        selectionStyle = .none
        [communityImageView,
         joinButton,
         communityNameLabel,
         infomartionStackView
        ].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        communityImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(56)
        }

        joinButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(communityImageView.snp.centerY)
            $0.height.equalTo(34)
            $0.width.equalTo(93)
        }

        infomartionStackView.snp.makeConstraints {
            $0.centerY.equalTo(communityImageView.snp.centerY)
            $0.leading.equalTo(communityImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(joinButton.snp.leading).offset(-14)
            $0.height.equalTo(56)
        }
    }

    // MARK: - User actions

    @objc
    private func joinButtonTapped() {

    }

    // MARK: - Public methods

    func configure(with viewModel: GeneralSearchCommunityViewModelProtocol) {
        guard let community = viewModel.community else { return }
        communityImageView.kf.setImage(
            with: URL(string: community.image ?? ""),
            placeholder: Assets.addedImagePlaceholder.image
        )

        communityNameLabel.text = community.name ?? ""
        recipeCountLabel.text = "\(community.recipesCount ?? 0)"
        membersCountLabel.text = "\(community.usersCount ?? 0)"
    }
}
