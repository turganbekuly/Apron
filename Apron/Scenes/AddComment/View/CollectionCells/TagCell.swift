//
//  TagCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import APRUIKit
import UIKit

public final class TagCell: UICollectionViewCell {

    // MARK: - Properties

    override public var isSelected: Bool {
        didSet {
            configureColors()
        }
    }

    // MARK: - Views

    private lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.5
        view.layer.borderColor = ApronAssets.gray.color.cgColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    public func configure(with viewModel: TagCellViewModelProtocol) {
        titleBackgroundView.backgroundColor = viewModel.backgroundColor
        titleLabel.attributedText = viewModel.title
    }

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
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview().offset(-2)
        }
    }

    private func configureColors() {
        titleBackgroundView.layer.borderWidth = isSelected ? 0 : 0.5
        titleBackgroundView.layer.borderColor = isSelected ? .none : ApronAssets.gray.color.cgColor
        titleBackgroundView.backgroundColor = isSelected
            ? ApronAssets.colorsYello.color
            : .white
        titleLabel.textColor = .black
    }

}
