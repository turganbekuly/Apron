//
//  FilterActionButton.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.10.2022.
//

import UIKit
import APRUIKit

enum FilterAddButtonType {
    case ingredients
    case cuisines
}

protocol FilterActionButtonProtocol: AnyObject {
    func actionButtonTapped(with type: FilterAddButtonType)
}

final class FilterActionButton: UICollectionViewCell {
    // MARK: - Properties

    private var type: FilterAddButtonType = .ingredients
    weak var delegate: FilterActionButtonProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(APRAssets.darkYello.color, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(addButton)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        addButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - User actions

    @objc
    private func addButtonTapped() {
        switch type {
        case .ingredients:
            delegate?.actionButtonTapped(with: .ingredients)
        case .cuisines:
            delegate?.actionButtonTapped(with: .cuisines)
        }
    }

    // MARK: - Methods

    func configure(with type: FilterAddButtonType) {
        self.type = type
        switch type {
        case .ingredients:
            addButton.setTitle("Добавить продукт +", for: .normal)
        case .cuisines:
            addButton.setTitle("Добавить кухню +", for: .normal)
        }
    }
}
