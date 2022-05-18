//
//  MyCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import UIKit
import DesignSystem

public protocol IMyCommunityCell: AnyObject {
    func myCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton)
}

public final class MyCommunityCell: UITableViewCell {
    // MARK: - Properties

    public weak var delegate: IMyCommunityCell?

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

    func configure(with viewModel: IMyCollectionDelegateCellViewModel) {
        titleLabel.text = viewModel.sectionHeaderTitle
        seeAllButton.isHidden = viewModel.showAllButtonEnabled
        communityCollectionView.delegate = viewModel.collectionDelegate
        communityCollectionView.dataSource = viewModel.collectionDelegate
    }
}

