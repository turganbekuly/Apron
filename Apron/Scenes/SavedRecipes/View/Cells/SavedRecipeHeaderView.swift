//
//  SavedRecipeHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.06.2022.
//

import UIKit
import APRUIKit

protocol SavedHeaderActionProtocol: AnyObject {
    func searchBarDidTap()
}

final class SavedRecipeHeaderView: UICollectionReusableView {
    // MARK: - Properties

    weak var delegate: SavedHeaderActionProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var searchView: NavigationSearchView = {
        let view = NavigationSearchView()
        return view
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(searchBarTapped))
        searchView.addGestureRecognizer(tapGR)
        addSubview(searchView)
        setupConstraints()
        configureColor()
    }

    private func setupConstraints() {
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    private func configureColor() {
        backgroundColor = APRAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func searchBarTapped() {
        delegate?.searchBarDidTap()
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityFilterCellViewModel) {
        self.searchView.titleLabel.text = "\(viewModel.searchbarPlaceholder)"
    }
}
