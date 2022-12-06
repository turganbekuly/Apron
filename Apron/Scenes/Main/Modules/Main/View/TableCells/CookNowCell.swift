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
    func navigateToRecipe(with id: Int)
}

final class CookNowCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: CookNowCellProtocol?
    lazy var recipesSection: [CookNowSection] = [] {
        didSet {
            cookNowCollectionView.reloadData()
        }
    }

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
        label.font = TypographyFonts.semibold18
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(ApronAssets.gray.color, for: .normal)
        button.setTitleColor(ApronAssets.gray.color, for: .highlighted)
        button.setTitle("Все", for: .normal)
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
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(seeAllButton.snp.leading).offset(-8)
        }

        seeAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }

        cookNowCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - User actions

    @objc
    private func seeAllButtonTapped() {

    }

    // MARK: - Public methods

    func configure(with viewModel: CookNowCellViewModelProtocol) {
        titleLabel.text = "Приготовить сейчас"
        recipesSection = [
            .init(section: .recipes, rows: viewModel.recipes.compactMap { .recipe($0) })
        ]
    }
}
