//
//  FilterOptionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import APRUIKit
import UIKit
import Models

final class FilterOptionCell: UICollectionViewCell {

    // MARK: - Properties

    override public var isSelected: Bool {
        didSet {
            configureColors()
        }
    }

    private var type: FilterOptionType?

    // MARK: - Views

    private lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 16
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(APRAssets.darkYello.color, for: .normal)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
    }

    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Setup views

    private func configureViews() {
        [titleBackgroundView].forEach {
            contentView.addSubview($0)
        }
        [titleLabel].forEach {
            titleBackgroundView.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        titleBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview().offset(-2)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        titleBackgroundView.backgroundColor = isSelected
        ? APRAssets.primaryTextMain.color : .white
        titleLabel.textColor = isSelected ? .white : .black
    }

    // MARK: - Methods

    func configure(with viewModel: FilterOptionCellViewModelProtocol) {
        titleBackgroundView.backgroundColor = viewModel.backgroundColor
        titleLabel.attributedText = viewModel.title
        type = viewModel.cellType
    }
}
