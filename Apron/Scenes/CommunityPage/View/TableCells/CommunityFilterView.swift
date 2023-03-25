//
//  CommunityFilterView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import APRUIKit
import UIKit

protocol SearchBarProtocol: AnyObject {
    func searchBarDidTap()
}

final class CommunityFilterView: UIView {
    // MARK: - Properties

    weak var delegate: SearchBarProtocol?

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

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(APRAssets.buttonFilterIcon.image, for: .normal)
        button.setBackgroundColor(.black, for: .normal)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(searchBarTapped))
        searchView.addGestureRecognizer(tapGR)
        [searchView].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        searchView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
//            $0.trailing.equalTo(filterButton.snp.leading).offset(-12)
            $0.bottom.equalToSuperview()
        }

//        filterButton.snp.makeConstraints {
//            $0.centerY.equalTo(searchView.snp.centerY)
//            $0.trailing.equalToSuperview()
//            $0.height.equalTo(38)
//            $0.width.equalTo(38)
//        }
    }

    // MARK: - User actions

    @objc
    private func searchBarTapped() {
        delegate?.searchBarDidTap()
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityFilterCellViewModel) {
        self.searchView.titleLabel.text = "Поиск в \(viewModel.searchbarPlaceholder)"
    }
}
