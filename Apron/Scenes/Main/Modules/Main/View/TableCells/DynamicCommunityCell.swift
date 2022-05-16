//
//  DynamicCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.05.2022.
//

import UIKit
import DesignSystem

protocol DynamicCommunityCellProtocol: AnyObject {
    func dynamicCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton)
}

final class DynamicCommunityCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: DynamicCommunityCellProtocol?

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
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.titleLabel?.textColor = Assets.gray.color
        return button
    }()

    lazy var communityCollectionView = MyCommunityCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel,
         seeAllButton,
         communityCollectionView
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
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

    // MARK: - Methods

    func configure(with viewModel: ICollectionDelegateCellViewModel) {
        titleLabel.text = viewModel.sectionHeaderTitle
        seeAllButton.setTitle("Посмотреть все", for: .normal)
        communityCollectionView.delegate = viewModel.collectionDelegate
        communityCollectionView.dataSource = viewModel.collectionDelegate
    }
}
