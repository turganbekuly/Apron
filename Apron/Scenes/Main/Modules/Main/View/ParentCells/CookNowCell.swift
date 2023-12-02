//
//  CookNowCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.12.2022.
//

import UIKit
import APRUIKit
import Models

protocol CookNowCellProtocol: AnyObject {
    func saveRecipeTappedv2(with id: Int)
    func navigateToAuthFromRecipev2()
    func navigateToRecipev2(with id: Int)
    func navigateToSeeAll(with type: CookNowCellType)
}

final class CookNowCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: CookNowCellProtocol?
    lazy var recipesSection: [CookNowSection] = [] {
        didSet {
            cookNowCollectionView.reloadData()
        }
    }

    var type: CookNowCellType = .cookNow

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold18
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(APRAssets.gray.color, for: .normal)
        button.setTitleColor(APRAssets.gray.color, for: .highlighted)
        button.setTitle(L10n.Common.all, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var cookNowCollectionView = CookNowCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            titleLabel,
            cookNowCollectionView,
            seeAllButton
        )
        cookNowCollectionView.delegate = self
        cookNowCollectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(seeAllButton.snp.leading).offset(-8)
        }

        seeAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }

        cookNowCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - User actions

    @objc
    private func seeAllButtonTapped() {
        delegate?.navigateToSeeAll(with: type)
    }

    // MARK: - Public methods

    func configure(with viewModel: CookNowCellViewModelProtocol) {
        let title = viewModel.sectionTitle
        titleLabel.text = title
        type = viewModel.type
        switch viewModel.state {
        case .failed:
            break
        case .loading:
            seeAllButton.isHidden = true
            recipesSection = [
                .init(section: .recipes, rows: Array(repeating: .shimmer, count: 2))
            ]
        case let .loaded(recipes):
            seeAllButton.isHidden = false
            recipesSection = [
                .init(section: .recipes, rows: recipes.compactMap { .recipe($0) })
            ]
        }
    }
}

extension CookNowCell: RecipeSearchCellV2Protocol {
    func saveRecipeTappedv2(with id: Int) {
        delegate?.saveRecipeTappedv2(with: id)
    }

    func navigateToAuthFromRecipev2() {
        delegate?.navigateToAuthFromRecipev2()
    }

    func navigateToRecipev2(with id: Int) {
        delegate?.navigateToRecipev2(with: id)
    }
}
