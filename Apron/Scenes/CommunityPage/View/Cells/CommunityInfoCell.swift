//
//  CommunityInfoCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import DesignSystem
import UIKit
import SnapKit
import HapticTouch

protocol ICommunityInfoCell: AnyObject {
    func joinButtonTapped(with id: Int)
}

final class CommunityInfoCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: ICommunityInfoCell?

    private var titleLabelTrailingToSuperviewConstraint: Constraint?
    private var titleLabelTrailingToInfoButtonConstraint: Constraint?

    var isJoined: Bool = false {
        didSet {
            configureButton(isJoined: isJoined)
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var roundedCornerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.tableRoundedCorners.image
        return imageView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var joinButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Вступить", for: .normal)
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        return button
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

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightGray.color
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        [roundedCornerView, containerView].forEach { contentView.addSubview($0) }
        [titleLabel, subtitleLabel, joinButton, recipeStackView, membersStackView, separatorView].forEach {
            containerView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        roundedCornerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(roundedCornerView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        joinButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(34)
            $0.width.greaterThanOrEqualTo(93)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(joinButton.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(joinButton.snp.leading).offset(-16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(separatorView.snp.top).inset(-12)
        }

        membersStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(recipeStackView.snp.trailing).offset(5)
            $0.bottom.equalTo(separatorView.snp.top).inset(-12)
        }
    }

    // MARK: - Private methods

    private func configureButton(isJoined: Bool) {
        if isJoined {
            joinButton.setTitle("Пригласить", for: .normal)
            joinButton.setBackgroundColor(Assets.colorsYello.color, for: .normal)
            joinButton.setBackgroundColor(Assets.colorsYello.color, for: .highlighted)
            joinButton.setBackgroundColor(Assets.colorsYello.color.withAlphaComponent(0.5), for: .disabled)
            joinButton.setTitleColor(.black, for: .normal)
        } else {
            joinButton.setTitle("Вступить", for: .normal)
        }
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityInfoCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.subtitleLabel.text = viewModel.subtitle
        self.recipeCountLabel.text = "\(viewModel.recipiesCount) рецептов"
        self.membersCountLabel.text = "\(viewModel.membersCount) подписчиков"
        self.isJoined = viewModel.isJoined
    }

    // MARK: - User actions

    @objc
    private func joinButtonTapped() {
        if isJoined {
            return
        }

        HapticTouch.generateSuccess()
        joinButton.setTitle("Пригласить", for: .normal)
        joinButton.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        joinButton.setBackgroundColor(Assets.colorsYello.color, for: .highlighted)
        joinButton.setBackgroundColor(Assets.colorsYello.color.withAlphaComponent(0.5), for: .disabled)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.greaterThanOrEqualTo(129)
        }
        layoutIfNeeded()
        isJoined = true
        delegate?.joinButtonTapped(with: 0)
    }
}
