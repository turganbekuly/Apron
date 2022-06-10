//
//  ImageHeaderView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import UIKit
import APRUIKit

final class ImageHeaderView: UIView {
    // MARK: - Public properties

    var imageHeight: CGFloat {
        return 188
    }

    var imageUrl: String? {
        didSet {
            if let imageUrl = imageUrl {
                setup(with: imageUrl)
            }
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    lazy var imageView = UIImageView()

    // MARK: - Configuration

    private func setupViews() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(205)
        }

        imageView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        })
    }
}

private extension ImageHeaderView {
    func setup(with imageUrl: String) {
        imageView.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: ApronAssets.communityMockImage.image,
            options: [.transition(.fade(0.4))]
        )
    }
}

