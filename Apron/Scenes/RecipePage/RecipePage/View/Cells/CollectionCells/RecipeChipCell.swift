//
//  RecipeChipCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import APRUIKit
import UIKit

final class RecipeChipCell: UICollectionViewCell {
    // MARK: - Views

    private lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = TypographyFonts.regular11
        label.textColor = .black
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

    // MARK: - Methods

    func configure(with viewModel: ChipCellViewModelProtocol) {
        guard viewModel.title?.length != .zero else { return }
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
}
