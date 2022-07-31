//
//  RecipeReviewsCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import UIKit
import APRUIKit
import SnapKit

final class RecipeReviewsCell: UITableViewCell {
    // MARK: - Sections

    struct Section {
        enum Section {
            case chips
        }
        enum Row {
            case chip(String)
        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties

    let boldAttributes = [
        NSAttributedString.Key.font: TypographyFonts.semibold12,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    let regularAttributes = [
        NSAttributedString.Key.font: TypographyFonts.regular12,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    var tagsCollectionViewHeight: Constraint?

    var sections: [Section] = []

    var tags: [String]? {
        didSet {
            guard let tags = tags, !tags.isEmpty else {
                return
            }
            sections = [.init(section: .chips, rows: tags.compactMap { .chip($0) })]
            contentView.layoutIfNeeded()
            tagsCollectionView.reloadData()
            tagsCollectionViewHeight?.update(offset: tagsCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = ApronAssets.lightGray.color
        return imageView
    }()

    private lazy var postAuthorLabel = UILabel()

    private lazy var postTextLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var tagsCollectionView: RecipeChipsCollectionView = {
        let collectionView = RecipeChipsCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            userImageView,
            postAuthorLabel,
            postTextLabel,
            tagsCollectionView
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(45)
        }

        postAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(userImageView.snp.trailing).offset(8)
        }

        tagsCollectionView.snp.makeConstraints {
            $0.top.equalTo(postAuthorLabel.snp.bottom).offset(4)
            $0.leading.equalTo(userImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            tagsCollectionViewHeight = $0.height.equalTo(0).constraint
        }

        postTextLabel.snp.makeConstraints {
            $0.top.equalTo(tagsCollectionView.snp.bottom).offset(4)
            $0.leading.equalTo(userImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Private methods

    private func configureAttributedText(name: String, time: String) {
        let attributedString = NSMutableAttributedString(string: name, attributes: boldAttributes)
        let normalString = NSMutableAttributedString(string: time, attributes: regularAttributes)
        attributedString.append(normalString)
        postAuthorLabel.attributedText = attributedString
        postAuthorLabel.numberOfLines = 2
    }


    // MARK: - Public methods

    func configure(with viewModel: RecipePageReviewsViewModelProtocol) {
        guard let comment = viewModel.comment else { return }
        configureAttributedText(name: comment.user ?? "", time: comment.createdAt ?? "")
        userImageView.image = ApronAssets.user.image
        postTextLabel.text = comment.description ?? ""
        tags = comment.tags ?? []
    }
}
