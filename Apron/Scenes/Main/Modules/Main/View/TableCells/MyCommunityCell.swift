//
//  MyCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import UIKit
import DesignSystem
import Models

protocol MyCommunityCellProtocol: AnyObject {
    func navigateToMyCommunity(with id: Int)
    func navigateToSeeAll()
}

public final class MyCommunityCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: MyCommunityCellProtocol?
    lazy var myCommunitiesSection: [MyCommunitiesSection] = [] {
        didSet {
            communityCollectionView.reloadData()
        }
    }

    var myCommunities: [CommunityResponse] = [] {
        didSet {
            if !myCommunities.isEmpty {
                myCommunitiesSection = [
                    .init(section: .myCommunities, rows: myCommunities.compactMap { .myCommunity($0) })
                ]
            } else {
                myCommunitiesSection = [.init(section: .myCommunities, rows: [.emptyView])]
            }
        }
    }

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        label.text = "Мое сообщество"
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(Assets.gray.color, for: .normal)
        button.setTitleColor(Assets.gray.color, for: .highlighted)
        button.setTitle("Все", for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var communityCollectionView = MyCommunityCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
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
        delegate?.navigateToSeeAll()
    }

    // MARK: - Methods

    func configure(with viewModel: IMyCollectionDelegateCellViewModel) {
        seeAllButton.isHidden = viewModel.myCommunities.count > 10 ? false : true
        myCommunities = viewModel.myCommunities
    }
}

