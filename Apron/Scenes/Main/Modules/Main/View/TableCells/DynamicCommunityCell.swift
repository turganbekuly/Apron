//
//  DynamicCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.05.2022.
//

import UIKit
import DesignSystem
import Models

protocol DynamicCommunityCellProtocol: AnyObject {
    func dynamicCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton)
}

final class DynamicCommunityCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: DynamicCommunityCellProtocol?
    weak var cellActionsDelegate: JoinCommunityProtocol?
    lazy var dynamicCommunitiesSection: [DynamicCommunitySection] = []
    var dynamicCommunities: [CommunityResponse] = [] {
        didSet {
            dynamicCommunitiesSection = [.init(section: .communities, rows: dynamicCommunities.compactMap { .community($0) })]
            communityCollectionView.reloadData()
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
        button.setTitleColor(Assets.gray.color, for: .normal)
        button.setTitleColor(Assets.gray.color, for: .highlighted)
        button.setTitle("Все", for: .normal)
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

    // MARK: - Methods

    func configure(with viewModel: IDynamicCollectionDelegateCellViewModel) {
        titleLabel.text = viewModel.sectionHeaderTitle
        seeAllButton.isHidden = viewModel.showAllButtonEnabled
        dynamicCommunities = viewModel.dynamicCommunities
    }
}
