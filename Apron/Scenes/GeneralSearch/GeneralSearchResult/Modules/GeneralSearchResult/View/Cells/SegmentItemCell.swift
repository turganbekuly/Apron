//
//  SegmentItemCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.05.2022.
//

import DesignSystem
import UIKit

public final class SegmentItemCell: UICollectionViewCell {

    // MARK: - Properties
    public override var isSelected: Bool {
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
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Lice Cycle
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    public func configure(with viewModel: SegmentCellViewModelProtocol) {
        titleLabel.attributedText = viewModel.title

        configureColors()
    }

    private func configureViews() {
        [titleBackgroundView, selectedView].forEach {
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
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        selectedView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        selectedView.backgroundColor = isSelected ? ApronAssets.colorsYello.color : .clear
        titleBackgroundView.backgroundColor = .clear
        titleLabel.textColor = isSelected ? .black : .gray
    }

}

