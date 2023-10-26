//
//  RecipeInformationViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.01.2022.
//

import APRUIKit
import UIKit
import RemoteConfig

final class RecipeInformationViewCell: UITableViewCell {
    // MARK: - Properties
    
    var onEditButtonTapped: (() -> Void)?
    var onShareButtonTapped: (() -> Void)?
    var onSourceLinkTapped: ((String?) -> Void)?
    
    private var sourceLink: String?
    
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
        imageView.isUserInteractionEnabled = true
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
    
    private lazy var sourceStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sourceLabel])
        view.axis = .horizontal
        view.spacing = 8
        view.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium14
        label.textColor = APRAssets.primaryTextMain.color
        label.isUserInteractionEnabled = true
        return label
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
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(sourceLinkHanlder))
        sourceLabel.addGestureRecognizer(tapGR)
        sourceStackView.addGestureRecognizer(tapGR)
        
        contentView.addSubviews(recipeImageView,recipeAuthorStackView)
        recipeImageView.addSubviews(ratingStackView, sourceStackView)
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
        
        sourceStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.height.equalTo(30)
        }
    }
    
    // MARK: - Private methods
    
    private func getSourceLink(with url: String) -> NSAttributedString {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: TypographyFonts.bold14,
            .foregroundColor: APRAssets.primaryTextMain.color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        return NSMutableAttributedString(
            string: url,
            attributes: yourAttributes
        )
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
    
    @objc
    private func sourceLinkHanlder() {
        onSourceLinkTapped?(sourceLink)
    }
    
    // MARK: - Methods
    
    func configure(with viewModel: IInformationCellViewModel) {
        recipeTitleLabel.text = viewModel.recipeName
        recipeByLabel.text = "от - \(viewModel.recipeAuthor ?? "Аноним")"
        let isSourceLinkEnabled = RemoteConfigManager.shared.configManager.config(for: RemoteConfigKeys.recipeSourceTypeEnabled)
        if
            isSourceLinkEnabled,
            let url = URL(string: viewModel.recipeSource ?? ""),
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let host = urlComponents.host,
            !host.contains("link.moca.kz")
        {
            sourceLink = viewModel.recipeSource
            sourceLabel.attributedText = getSourceLink(with: host)
        } else {
            sourceStackView.isHidden = true
        }
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
        
        sourceStackView.layoutIfNeeded()
        recipeAuthorStackView.layoutIfNeeded()
        ratingStackView.layoutIfNeeded()
    }
}
