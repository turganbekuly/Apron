//
//  StepPagerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.09.2022.
//

import APRUIKit
import UIKit

public final class StepPagerCell: UICollectionViewCell {

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
        view.layer.cornerRadius = 8
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

    // MARK: - Lice Cycle

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods

    public func configure(with viewModel: StepPagerCellViewModelProtocol) {
        titleLabel.attributedText = viewModel.title

        configureColors()
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        titleBackgroundView.backgroundColor = isSelected ? .black : ApronAssets.lightGray2.color
        titleLabel.textColor = .white
    }

}
