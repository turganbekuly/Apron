//
//  GeneralSearchRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit
import APRUIKit
import Models
import Storages
import HapticTouch

protocol GeneralSearchRecipeCellProtocol: AnyObject {
    func didTapSaveRecipe(with id: Int)
    func navigateToAuthFromRecipe()
    func navigateToRecipe(with id: Int)
}

final class GeneralSearchRecipeCell: UITableViewCell {
    // MARK: - Private properties

    private var id = 0
    private var isSaved: Bool = false {
        didSet {
            configureButton(isSaved: isSaved)
        }
    }

    // MARK: - Public properties

    weak var delegate: GeneralSearchRecipeCellProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.contentView.transform = self.contentView.transform.scaledBy(
                    x: 0.9,
                    y: 0.9
                )
            }
        )
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesEnded(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0.07,
            options: [.beginFromCurrentState],
            animations: {
                self.contentView.transform = .identity
            }
        )
    }

    // MARK: - Views factory

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = APRAssets.heart24White.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var sourceLinkLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = APRAssets.gray.color
        label.textAlignment = .left
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeNameLabel, sourceLinkLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(faveButtonTapped))
        favoriteImageView.addGestureRecognizer(tapGR)
        
        [recipeImageView, stackView, favoriteImageView].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        recipeImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.equalTo(56)
            $0.bottom.equalToSuperview()
        }

        favoriteImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(recipeImageView.snp.centerY)
            $0.size.equalTo(24)
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalTo(recipeImageView.snp.centerY)
            $0.leading.equalTo(recipeImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(favoriteImageView.snp.leading).offset(-14)
        }
    }

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteImageView.image = APRAssets.heart24White.image
                .withRenderingMode(.alwaysTemplate)
                .withTintColor(.black)
            return
        }
        
        favoriteImageView.image = APRAssets.heartFilled24White.image
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(.black)
    }

    // MARK: - User actions
    
    @objc
    private func faveButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            delegate?.navigateToAuthFromRecipe()
            return
        }
        
        guard !isSaved else {
            delegate?.navigateToRecipe(with: id)
            return
        }
        
        delegate?.didTapSaveRecipe(with: id)
        ApronAnalytics.shared.sendAnalyticsEvent(.recipeAddedToFavorite(recipeNameLabel.text ?? ""))
        HapticTouch.generateSuccess()
        favoriteImageView.image = APRAssets.heartFilled24White.image
    }

    // MARK: - Public methods

    func configure(with viewModel: GeneralSearchRecipeViewModelProtocol) {
        guard let recipe = viewModel.recipe else { return }
        isSaved = recipe.isSaved ?? false
        id = recipe.id
        recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: APRAssets.addedImagePlaceholder.image
        )

        recipeNameLabel.text = recipe.recipeName ?? ""
        sourceLinkLabel.text = recipe.sourceLink ?? ""
    }
}
