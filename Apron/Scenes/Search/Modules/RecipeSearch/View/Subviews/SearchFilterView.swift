//
//  SearchFilterView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.12.2022.
//

import UIKit
import APRUIKit

enum SearchFilterType {
    case filters
}

final class SearchFilterView: UIView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(28)
        }

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Private methods

    private func configureFilterState(
        type: SearchFilterType,
        filter count: Int
    ) {
        if count < 1 {
            containerView.backgroundColor = .white
            titleLabel.textColor = APRAssets.gray.color
            titleLabel.text = type == .filters ? L10n.RecipeSearch.AllFilters.title : ""
            return
        }

        containerView.backgroundColor = APRAssets.mainAppColor.color
        containerView.layer.borderColor = APRAssets.mainAppColor.color.cgColor
        titleLabel.textColor = .white
        titleLabel.text = type == .filters ? "Все фильтры · \(count)" : ""
    }

    // MARK: - Methods

    func configure(
        type: SearchFilterType,
        filters count: Int
    ) {
        configureFilterState(type: type, filter: count)
    }
}
