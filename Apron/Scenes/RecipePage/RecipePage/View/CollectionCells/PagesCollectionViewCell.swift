//
//  PagesCollectionViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.01.2022.
//

import DesignSystem
import UIKit

public final class PagesCollectionViewCell: UICollectionViewCell {

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
        view.layer.cornerRadius = 17
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
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

    public func configure(with viewModel: ISegmentCollectionViewModel) {
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
        snp.makeConstraints {
            $0.height.equalTo(34)
        }

        titleBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        titleBackgroundView.backgroundColor = isSelected ? Assets.colorsYello.color : .clear
        titleLabel.textColor = isSelected ? .black : Assets.gray.color
    }

}

