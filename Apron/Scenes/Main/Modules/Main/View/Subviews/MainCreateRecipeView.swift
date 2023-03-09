//
//  MainCreateRecipeView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.03.2023.
//

import UIKit
import APRUIKit

final class MainCreateRecipeView: View {
    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 20
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowColor = ApronAssets.primaryTextMain.color.cgColor
        return view
    }()

    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium14
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Setup Views

    // MARK: - Methods
}
