//
//  RecipeInformationViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.01.2022.
//

import APRUIKit
import UIKit

final class RecipeInformationViewCell: UITableViewCell {
    // MARK: - Properties
    
    var onEditButtonTapped: (() -> Void)?
    var onShareButtonTapped: (() -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views factory
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular10
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = L10n.GeneralSearchInitialState.Ru.recipe.uppercased()
        return label
    }()
    
    private lazy var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var recipeByLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var recipeAuthorStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 15
        return view
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ratingLabel, ratingView])
        view.axis = .horizontal
        view.spacing = 8
        view.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 15
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium14
        label.textColor = APRAssets.primaryTextMain.color
        return label
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 11
        return view
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        isUserInteractionEnabled = true
        [
            recipeImageView,
            recipeAuthorStackView
        ].forEach { contentView.addSubview($0) }
        
        recipeImageView.addSubview(ratingStackView)
        ratingView.addSubview(ratingImageView)
        recipeAuthorStackView.addArrangedSubviews(
            titleLabel,
            recipeTitleLabel,
            recipeByLabel
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        recipeImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        recipeAuthorStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(recipeImageView.snp.bottom)
            $0.height.greaterThanOrEqualTo(100)
        }
        
        ratingView.snp.makeConstraints {
            $0.size.equalTo(22)
        }
        
        ratingImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
        
        ratingStackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - User actions
    
    @objc
    private func editButtonTapped() {
        onEditButtonTapped?()
    }
    
    @objc
    private func shareButtonTapped() {
        onShareButtonTapped?()
    }
    
    // MARK: - Methods
    
    func configure(with viewModel: IInformationCellViewModel) {
        recipeTitleLabel.text = viewModel.recipeName
        recipeByLabel.text = "от - \(viewModel.recipeAuthor ?? "Аноним")"
        recipeImageView.kf.setImage(
            with: URL(string: viewModel.recipeImage ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image,
            options: [.transition(.fade(0.4))]
        )
        
        let likesCount = viewModel.likeCount
        let dislikesCount = viewModel.dislikeCount
        if likesCount > 0 && dislikesCount >= 0 {
            let percentRatio = ((likesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio)%"
            ratingImageView.isHidden = false
            ratingImageView.image = APRAssets.recipeLikeSelected.image.withTintColor(.white)
            ratingView.backgroundColor = APRAssets.mainAppColor.color
        } else if dislikesCount > 0 && likesCount == 0 {
            let percentRatio = ((dislikesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio)%"
            ratingImageView.isHidden = false
            ratingImageView.image = APRAssets.recipeDislikeSelected.image.withTintColor(.white)
            ratingView.backgroundColor = APRAssets.red.color
        } else if likesCount <= 0 && dislikesCount <= 0 {
            ratingStackView.isHidden = true
        }
        
        recipeAuthorStackView.layoutIfNeeded()
        ratingStackView.layoutIfNeeded()
    }
}
