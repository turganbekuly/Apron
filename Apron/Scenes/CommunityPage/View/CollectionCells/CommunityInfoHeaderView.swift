//
//  CommunityInfoHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import APRUIKit
import UIKit
import SnapKit
import HapticTouch
import Storages

protocol ICommunityInfoCell: AnyObject {
    func joinButtonTapped(with id: Int)
    func inviteButtonTapped()
    func navigateToAuth()
}

final class CommunityInfoHeaderView: UICollectionReusableView {
    // MARK: - Properties

    weak var delegate: ICommunityInfoCell?

    private var titleLabelTrailingToSuperviewConstraint: Constraint?
    private var titleLabelTrailingToInfoButtonConstraint: Constraint?

    var isJoined: Bool = false {
        didSet {
            configureButton(isJoined: isJoined)
        }
    }

    var id = 0

    weak var filterViewDelegate: SearchBarProtocol? {
        didSet {
            filterView.delegate = filterViewDelegate
        }
    }
    weak var segmentDelegate: ICommunitySegmentCell? {
        didSet {
            segmentView.delegate = segmentDelegate
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var roundedCornerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.tableRoundedCorners.image
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
        imageView.image = APRAssets.cmntRecipeIcon.image
        return imageView
    }()

    private lazy var recipeCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular11
        label.textColor = APRAssets.gray.color
        return label
    }()

    private lazy var membersImageView: UIImageView = {
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
        view.backgroundColor = APRAssets.lightGray2.color
        return view
    }()

    private lazy var filterView = CommunityFilterView()
    private lazy var segmentView = CommunitySegmentView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [roundedCornerView, containerView].forEach {
            addSubview($0)
        }
        
        // TODO: - If segmentView and memberStackview needed uncomment its content
        
        [
            titleLabel,
            subtitleLabel,
            recipeStackView,
//            membersStackView,
            separatorView
//            filterView
//            segmentView
        ].forEach {
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
            $0.top.equalTo(recipeStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }

//        membersStackView.snp.makeConstraints {
//            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
//            $0.leading.equalTo(recipeStackView.snp.trailing).offset(5)
//        } 

//        filterView.snp.makeConstraints {
//            $0.top.equalTo(separatorView.snp.bottom).offset(18)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(38)
//        }

//        segmentView.snp.makeConstraints {
//            $0.top.equalTo(filterView.snp.bottom).offset(24)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(34)
//        }
    }

    // MARK: - Private methods

    private func configureButton(isJoined: Bool) {
        if isJoined {
            joinButton.setTitle("Пригласить", for: .normal)
            joinButton.setBackgroundColor(APRAssets.colorsYello.color, for: .normal)
            joinButton.setBackgroundColor(APRAssets.colorsYello.color, for: .highlighted)
            joinButton.setBackgroundColor(APRAssets.colorsYello.color.withAlphaComponent(0.5), for: .disabled)
            joinButton.setTitleColor(.black, for: .normal)
        } else {
            joinButton.setTitle("Вступить", for: .normal)
        }
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityInfoCellViewModel) {
        guard let community = viewModel.community else { return }
        self.titleLabel.text = community.name ?? ""
        self.subtitleLabel.text = community.description ?? ""
        self.recipeCountLabel.text = "\(community.recipesCount ?? 0) рецептов"
        self.membersCountLabel.text = "\(community.usersCount ?? 0) подписчиков"
        self.isJoined = community.joined ?? false
        self.id = community.id
//        segmentView.configure(
//            with: CommunitySegmentedCellViewModel(filter: CommunitySegmentView.CommunitySegment.recipes)
//        )
//        filterView.configure(with: CommunityFilterCellViewModel(searchbarPlaceholder: viewModel.searchbarPlaceholder))
    }

    // MARK: - User actions

    @objc
    private func joinButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            delegate?.navigateToAuth()
            return
        }

        if isJoined {
            delegate?.inviteButtonTapped()
            return
        }

        HapticTouch.generateSuccess()
        joinButton.setTitle("Пригласить", for: .normal)
        joinButton.setBackgroundColor(APRAssets.colorsYello.color, for: .normal)
        joinButton.setBackgroundColor(APRAssets.colorsYello.color, for: .highlighted)
        joinButton.setBackgroundColor(APRAssets.colorsYello.color.withAlphaComponent(0.5), for: .disabled)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.snp.updateConstraints {
            $0.width.greaterThanOrEqualTo(129)
        }
        layoutIfNeeded()
        isJoined = true
        delegate?.joinButtonTapped(with: id)
    }
}
