//
//  CookNowEmptyCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.12.2022.
//

import UIKit
import APRUIKit

final class CookNowEmptyCollectionCell: UICollectionViewCell {
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
        numberOfColumns: 1,
        numberOfRows: 1,
        itemWidth: bounds.width,
        itemHeight: 160,
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
            $0.edges.equalToSuperview()
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
