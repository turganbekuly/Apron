//
//  PreShoppingCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.07.2022.
//

import UIKit
import APRUIKit
import M13Checkbox
import HapticTouch
import Storages

final class PreShoppingCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            checkbox.setCheckState(.checked, animated: true)
            HapticTouch.generateSuccess()
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
            HapticTouch.generateError()
        }
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        return view
    }()

    private lazy var measurementLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()

    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()

    lazy var checkbox: M13Checkbox = {
        let checkbox = M13Checkbox()
        checkbox.boxType = .square
        checkbox.cornerRadius = 8
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = ApronAssets.mainAppColor.color
        checkbox.secondaryTintColor = .gray
        checkbox.secondaryCheckmarkTintColor = .white
        checkbox.isUserInteractionEnabled = false
        return checkbox
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            measurementLabel,
            ingredientLabel,
            checkbox
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }

        checkbox.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        measurementLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
        }

        ingredientLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(measurementLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(checkbox.snp.leading).offset(-8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure(ingredient: CartItem) {
        ingredientLabel.text = ingredient.productName
        if let amount = ingredient.amount,
           let measure = ingredient.measurement {
            measurementLabel.text = "\(amount.clean) \(measure)"
        }
    }
}
