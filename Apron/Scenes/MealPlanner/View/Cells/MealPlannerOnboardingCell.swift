//
//  MealPlannerOnboardingCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 14.10.2023.
//

import UIKit
import APRUIKit

protocol MealPlannerOnboardingCellProtocol: AnyObject {
    func showOnboarding()
}

final class MealPlannerOnboardingCell: UITableViewCell {
    // MARK: - Properties
    
    weak var delegate: MealPlannerOnboardingCellProtocol?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views factory
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = APRAssets.brown.color
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.bold16
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = L10n.MealPlanner.Onboarding.title
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.regular16
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.MealPlanner.Onboarding.message
        return label
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: TypographyFonts.bold18,
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        
        let attributeString = NSMutableAttributedString(
            string: "Посмотреть как",
            attributes: yourAttributes
        )

        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(showHowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubviews(titleLabel, descriptionLabel, showButton)
        makeConstraints()
        configureColors()
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        showButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func configureColors() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    // MARK: - User actions

    @objc
    private func showHowButtonTapped() {
        delegate?.showOnboarding()
    }
}
