//
//  RecipeCreationPlaceholderImageCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.04.2022.
//

import UIKit
import APRUIKit
import NVActivityIndicatorView

protocol RecipeCreationPlaceholderImageCellProtocol: AnyObject {
    func chooseImageDidTapped()
}

final class RecipeCreationPlaceholderImageCell: UITableViewCell {
    // MARK: - Private properties

    private var isLoading = false
    
    // MARK: - Public properties

    weak var delegate: RecipeCreationPlaceholderImageCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imagePlaceholder = PhotoPlaceholderView()
    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: ApronAssets.colorsYello.color,
        padding: nil
    )

    // MARK: - Setup Views

    private func setupViews() {
        selectionStyle = .none
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))
        imagePlaceholder.addGestureRecognizer(tapGR)
        contentView.addSubviews(
            imagePlaceholder,
            activityIndicator
        )
        activityIndicator.isHidden = true
        activityIndicator.alpha = 0.0
        setupConstraints()
    }

    private func setupConstraints() {
        imagePlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(45)
        }
    }

    // MARK: - Private methods

    @objc
    private func chooseImageTapped() {
        delegate?.chooseImageDidTapped()
    }

    // MARK: - Public methods

    // MARK: - Public methods

    public func startAnimating() {
        activityIndicator.color = ApronAssets.colorsYello.color

        isLoading = true
        isUserInteractionEnabled = false

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        UIView.animate(withDuration: 0.25) {
            self.imagePlaceholder.alpha = 0.0
            self.activityIndicator.alpha = 1.0
        }
    }

    public func stopAnimating() {
        isLoading = false

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.isUserInteractionEnabled = true
        }
        CATransaction.setAnimationDuration(0.15)

        self.activityIndicator.alpha = 0.0
        self.imagePlaceholder.alpha = 1.0
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = false

        CATransaction.commit()
    }

    func configure() {

    }
}
