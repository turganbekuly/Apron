//
//  SearchHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import DesignSystem

final class SearchHeaderView: UITableViewHeaderFooterView {
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory
    private lazy var searchView = NavigationSearchView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            searchView
        )
        setupConstraints()
    }

    private func setupConstraints() {
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
        }
    }

    // MARK: - Public methods

    func configure() {
    }
}
