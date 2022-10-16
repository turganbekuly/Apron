//
//  FiltersHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import APRUIKit
import UIKit

final class FiltersHeaderView: UICollectionReusableView {

    // MARK: - Properties

    override var frame: CGRect {
        get {
            super.frame
        }
        set {
            if newValue.width == 0 { return }

            super.frame = newValue
        }
    }

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
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

    // MARK: - Methods

    func configure(with viewModel: FilterHeaderViewModel) {
        titleLabel.attributedText = viewModel.title

        configureColors()
    }

    private func configureViews() {
        [titleLabel].forEach {
            addSubview($0)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }

    private func configureColors() {
        backgroundColor = .clear
        titleLabel.textColor = .black
    }

}

