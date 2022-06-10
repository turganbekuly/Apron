//
//  DynamicCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.05.2022.
//

import UIKit
import APRUIKit
import Models

protocol DynamicCommunityCellProtocol: AnyObject {
    func navigateToCommunity(with id: Int)
    func navigateToSeeAll(with categoryID: Int, title: String)
}

final class DynamicCommunityCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: DynamicCommunityCellProtocol?
    weak var cellActionsDelegate: JoinCommunityProtocol?
    lazy var dynamicCommunitiesSection: [DynamicCommunitySection] = [] {
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
    var dynamicCommunities: [CommunityResponse] = [] {
        didSet {
            if !dynamicCommunities.isEmpty {
                dynamicCommunitiesSection = [
                    .init(section: .communities, rows: dynamicCommunities.compactMap { .community($0) })
                ]
            } else {
                dynamicCommunitiesSection = [.init(section: .communities, rows: Array(repeating: .loader, count: 10))]
            }
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
        button.setTitleColor(ApronAssets.gray.color, for: .normal)
        button.setTitleColor(ApronAssets.gray.color, for: .highlighted)
        button.setTitle("Все", for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var communityCollectionView = DynamicCommunityCollectionView()

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
            $0.top.leading.equalToSuperview().inset(16)
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
        selectionStyle = .none
    }

    // MARK: - User actions

    @objc
    private func seeAllButtonTapped() {
        delegate?.navigateToSeeAll(with: categoryID, title: title)
    }

    // MARK: - Methods

    func configure(with viewModel: IDynamicCollectionDelegateCellViewModel) {
        title = viewModel.sectionHeaderTitle
        seeAllButton.isHidden = viewModel.dynamicCommunities.count > 10 ? false : true
        dynamicCommunities = viewModel.dynamicCommunities
        categoryID = viewModel.categoryID
    }
}
