//
//  CommunityCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 13.08.2023.
//

import UIKit
import APRUIKit
import Models

protocol CommunityCellProtocol: AnyObject {
    func navigateToCommunity(with id: Int)
    func navigateToSeeAll(with categoryID: Int, title: String)
}

final class CommunityCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: CommunityCellProtocol?
    lazy var communitiesSection: [CommunitySection] = [] {
        didSet {
            communityCollectionView.reloadData()
        }
    }
    var categoryID = 0
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var communities: [CommunityResponse] = [] {
        didSet {
            guard !communities.isEmpty else { return }
            communitiesSection = [
                .init(section: .communities, rows: communities.compactMap { .community($0) })
            ]
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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(APRAssets.gray.color, for: .normal)
        button.setTitleColor(APRAssets.gray.color, for: .highlighted)
        button.setTitle(L10n.Common.all, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var communityCollectionView = CommunityCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel,
         seeAllButton,
         communityCollectionView
        ].forEach {
            contentView.addSubview($0)
        }
        communityCollectionView.delegate = self
        communityCollectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(seeAllButton.snp.leading).offset(-8)
        }

        seeAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }

        communityCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - User actions

    @objc
    private func seeAllButtonTapped() {
        delegate?.navigateToSeeAll(with: categoryID, title: title)
    }

    // MARK: - Methods

    func configure(with viewModel: CommunityCellViewModelProtocol) {
        title = viewModel.sectionHeaderTitle
        seeAllButton.isHidden = viewModel.communities
            .filter { $0.isHidden == false }
            .count >= 10 ? false : true
        communities = viewModel.communities.filter { $0.isHidden == false }
    }
}

