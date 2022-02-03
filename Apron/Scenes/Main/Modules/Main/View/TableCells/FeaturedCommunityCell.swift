//
//  FeaturedCommunityCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import UIKit
import DesignSystem

public protocol IFeaturedCommunityCell: AnyObject {
    func featuredCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton)
}

public final class FeaturedCommunityCell: UITableViewCell {
    // MARK: - Properties

    public weak var delegate: IFeaturedCommunityCell?

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var communityCollectionView = FeaturedCommunityCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(communityCollectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        communityCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    func configure(with viewModel: ICollectionDelegateCellViewModel) {
        communityCollectionView.delegate = viewModel.collectionDelegate
        communityCollectionView.dataSource = viewModel.collectionDelegate
    }
}


