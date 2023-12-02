//
//  RoundedTopView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.10.2022.
//

import UIKit
import APRUIKit

final class RoundedTopView: View {
    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.1
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold14
        label.textColor = .white
        return label
    }()

    // MARK: - Setup views

    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        imageView.addSubviews(overlayView, label)
    }

    override func setupConstraints() {
        super.setupConstraints()

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        overlayView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(8)
        }
    }

    // MARK: - Public methods

    func configure(with viewModel: RoundedTopViewModelProtocol) {
        imageView.kf.setImage(
            with: URL(string: viewModel.image ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )

        label.text = viewModel.label
    }
}
