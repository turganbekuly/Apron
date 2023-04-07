//
//  SearchHistoryCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import UIKit
import APRUIKit
import Storages

protocol SearchHistoryCollectionCellDelegate: AnyObject {
    func searchHistorySelected(with search: SearchHistoryItem)
    func removeButtonTapped(with search: SearchHistoryItem)
}

final class SearchHistoryCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: SearchHistoryCollectionCellDelegate?
    private var searchItem: SearchHistoryItem? {
        didSet {
            guard let searchItem = searchItem else {
                return
            }
            textLabel.attributedText = Typography.regular14(
                text: searchItem.text,
                color: APRAssets.gray.color
            ).styled
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

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = APRAssets.gray.color.cgColor
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = APRAssets.closeIcon.image.withTintColor(APRAssets.gray.color)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeButtonTapped)))
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(historyTapped)))
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(imageView, textLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.trailing.leading.equalToSuperview()
        }

        textLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalTo(imageView.snp.leading).offset(-8)
            $0.centerY.equalTo(imageView.snp.centerY)
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
    }

    // MARK: - User actions

    @objc
    private func removeButtonTapped() {
        guard let searchItem = searchItem else {
            return
        }

        delegate?.removeButtonTapped(with: searchItem)
    }

    @objc
    private func historyTapped() {
        guard let searchItem = searchItem else {
            return
        }

        delegate?.searchHistorySelected(with: searchItem)
    }

    // MARK: - Methods

    func configure(searchItem: SearchHistoryItem) {
        self.searchItem = searchItem
    }
}
