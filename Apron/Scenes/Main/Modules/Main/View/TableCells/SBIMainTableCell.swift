//
//  SBIMainTableCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit
import APRUIKit
import Models

protocol SBIMainTableCellDelegate: AnyObject {
    func sbiProductSelected()
}

final class SBIMainTableCell: UITableViewCell {
    // MARK: - Properties

    lazy var productsSection: [SBIMainSection] = [] {
        didSet {
            productsCollectionView.reloadData()
        }
    }

    weak var delegate: SBIMainTableCellDelegate?
    
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
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    lazy var productsCollectionView = SBICollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            titleLabel,
            descriptionLabel,
            productsCollectionView
        )
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        productsCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    // MARK: - Public methods

    func configure(with viewModel: SBIMainViewModel) {
        titleLabel.text = viewModel.sectionTitle
        descriptionLabel.text = viewModel.sectionDescription
        productsSection = [
            .init(section: .products, rows: viewModel.products.compactMap { .product($0) })
        ]
    }
}

