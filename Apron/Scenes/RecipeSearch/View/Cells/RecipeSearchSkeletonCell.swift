//
//  RecipeSearchSkeletonCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.10.2022.
//

import UIKit
import APRUIKit

final class RecipeSearchSkeletonCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        skeletonView.stopSkeletonAnimation()
    }

    // MARK: - Views factory

    private lazy var skeletonView = SkeletonPlaceholderView(
        numberOfColumns: 2,
        numberOfRows: 3,
        itemWidth: (bounds.width / 2) - 24,
        itemHeight: 300,
        cellCornerRadius: 20
    )

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(skeletonView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        skeletonView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Public methods

    func configure() {
        skeletonView.startSkeleton(type: .advanced)
    }
}
