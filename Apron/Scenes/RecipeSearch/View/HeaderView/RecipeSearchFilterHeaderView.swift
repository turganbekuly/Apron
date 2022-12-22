//
//  RecipeSearchFilterHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.12.2022.
//

import UIKit
import APRUIKit
import HapticTouch

protocol RecipeSearchFilterHeaderViewProtocol: AnyObject {
    func headerViewTapped()
}

final class RecipeSearchFilterHeaderView: UICollectionReusableView {
    // MARK: - Properties

    weak var delegate: RecipeSearchFilterHeaderViewProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView = UIView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var allFiltersView = SearchFilterView()

    // MARK: - Setup Views

    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        containerView.addGestureRecognizer(tapGR)
        containerView.isUserInteractionEnabled = true
        addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(allFiltersView)
        setupConstraints()
        setupColors()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(60)
        }

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }

        allFiltersView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }

    private func setupColors() {
        backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func headerViewTapped() {
        HapticTouch.generateMedium()
        delegate?.headerViewTapped()
    }

    // MARK: - Methods

    func configure(type: SearchFilterType, filters count: Int) {
        switch type {
        case .filters:
            allFiltersView.configure(type: type, filters: count)
        }
    }
}
