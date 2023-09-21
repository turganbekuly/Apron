//
//  StepPagerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.09.2022.
//

import APRUIKit
import UIKit

final class StepPagerCell: UICollectionViewCell {

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
        label.textColor = .white
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var stackView = UIStackView()

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

    private func configureViews() {
        [titleBackgroundView].forEach {
            contentView.addSubview($0)
        }
        [stackView].forEach {
            titleBackgroundView.addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        titleBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        titleBackgroundView.backgroundColor = isSelected ? APRAssets.primaryTextMain.color : APRAssets.lightGray.color
        titleLabel.textColor = .white
    }

    // MARK: - Methods

    func configure(with viewModel: StepPagerCellViewModelProtocol) {
        stackView.removeAllArrangedSubviews()
        configureColors()
        if let title = viewModel.title, title.length != 0 {
            titleLabel.attributedText = title
            stackView.addArrangedSubview(titleLabel)
            return
        }

        imageView.image = viewModel.image
        stackView.addArrangedSubview(imageView)
    }

}
